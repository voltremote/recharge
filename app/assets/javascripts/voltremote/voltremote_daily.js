vr.graphs.daily = function(container, layout) {
  var onSelect = function(data) {},
      onDeselect = function(data) {},
      svg = container,
      group = container.append("g").attr("id", "chart"),
      layout = layout;
      
  var current_data = { consumption:[], production:[] }; 
  var stack = d3.layout.stack().values(function(d) { return d.values; });

  
  var layers = 2,
      samples = 24*1;
    
  var margin = 20,
      left_axis = layout.left,
      width = layout.width - layout.left,
      height = layout.height - margin - 0.5,
      mx = samples,
      my = 0, mz = 0,
      x = function(d) { return d.x * width / mx; }, 
      y0, y1, y2;
      
      
  // x Legend  
  var texts = group
    .append("g")
    .attr("class", "legend_x");
  
  var ticks = texts.selectAll("g.tick")
    .data(vr.integerGenerator(23))
    .enter().append("g").attr("class", "tick")
    .attr("transform", function(d) { return "translate(" + [ left_axis + x({x:d * 4}), height ] + ")" });
    
  ticks.append("line")
      .attr("y1", 1)
      .attr("y2", 4);
    
  var labels = texts.selectAll("text.label")
    .data(vr.integerGenerator(23))
    .enter().append("text")
    .attr("class", "label")
    .attr("x", function(d) {return left_axis + x({x:d*1}); })
    .attr("y", height + 6)
    .attr("dx", x({x: .45}))
    .attr("dy", ".71em")
    .attr("text-anchor", "middle")
     .text(function(d, i) { return "" + d });
     
  // selection marker
  var selection = group.append("g")
        .attr("class", "selection")
        .attr("transform", "translate(0, 0)")
        .style("display", "none")
        .on("click", function(d) {
          selection.style("display", "none");
          d3.event.stopPropagation();
          onDeselect || onDeselect(null);
        });
        
  selection.append("rect")
       .attr("x", left_axis)
       .attr("y", 0)
       .attr("height", height)
       .attr("width", 4*(width/samples));
       
  var old_x_pos = 0;
  
        
  
  function daily(data) {
    current_data = data;
    
    var zipped = d3.zip(data.consumption, data.production);
    var ratios = zipped.map(function(d) {
      var r = d[0] - d[1];
      if (r < 0) {
        r = 0;
      }
      return [ r, d[1]];
    });
    
    var cons_data = ratios.map(function(d, i) { return {x:i, y:d[0]}; });
    var prod_data = ratios.map(function(d, i) { return {x:i, y:d[1]}; });
    
    var layer = [{ name:"production", values:prod_data }, { name:"consumption", values:cons_data }];
    var stacked = stack(layer);
    
    my = d3.max(stacked, function(d) {
      return d3.max(d.values, function(d) {
        return d.y0 + d.y;
     });
    }),
    mz = d3.max(stacked, function(d) {
      return d3.max(d.values, function(d) {
        return d.y;
      }); 
    }),
    x = function(d) { return d.x * width / mx; },
    y0 = function(d) { return height - d.y0 * height / my; },
    y1 = function(d) { return height - (d.y + d.y0) * height / my; },
    y2 = function(d) { return d.y * height / mz; };
    
    // y axis
    var y_scale = d3.scale.linear()
      .domain([0, Math.max(data.max_production, data.max_consumption)])
      .range([height, layout.bottom ])
    var texts = group
      .append("g")
      .attr("class", "legend_y");
        
    var ticks = texts.selectAll("g.tick")
      .data(y_scale.ticks(10))
      .enter().append("g").attr("class", "tick")
      .attr("transform", function(d) { return "translate(" + [ left_axis - 5, y_scale(d) ] + ")" });
      
    var labels = texts.selectAll("text.label")
    .data(y_scale.ticks(10))
    .enter().append("text")
    .attr("class", "label")
    .attr("x", 15)
    .attr("y", function(d) { return y_scale(d) - 4; })
    .attr("dx", x({x: .45}))
    .attr("dy", ".71em")
    .attr("text-anchor", "middle")
     .text(function(d, i) { return "" + d });
      
    ticks.append("line")
        .attr("x1", 1)
        .attr("x2", 4);
    
    var layers = group.selectAll("g.data")
                .data(stacked);
    layers.enter().append("g")
          .attr("class", function(d) { return "data " + d.name });
                        
    var bars = layers.selectAll("g.bar")
                     .data(function(d) {return d.values;})
    var entered = bars.enter().append("g")
                      .attr("class", "bar")
                      .attr("transform", function(d) { return "translate(" + (left_axis + x(d)) + ",0)"; })
                     
    entered.append("rect")
        .attr("width", x({x: 0.9}))
        .attr("x", 0)
        .attr("y", height)
        .attr("height", 0)
        .transition()
          .delay(function(d, i) { return i * 10; })
          .attr("y", y1)
          .attr("height", function(d) { return y0(d) - y1(d); });
        
    bars.select("rect")
        .transition()
        .attr("y", y1)
        .attr("height", function(d) { return y0(d) - y1(d); });
  }
  
  daily.onSelect = function(f) {
    if (!arguments.length) return onSelect;
    onSelect = f || function(data) {};
    
    return daily;
  }
  
  daily.onDeselect = function(f) {
    if (!arguments.length) return onDeselect;
    onDeselect = f || function(data) {};
    
    return daily;
  }
  
  daily.deviationAt = function(hour) {
    var data = current_data;
    var deviation = 0;

    if (hour != null){
      hour *= 4;
      var prod = data.production[hour] + data.production[hour + 1] + data.production[hour + 2] + data.production[hour + 3];
      var cons = data.consumption[hour] + data.consumption[hour + 1] + data.consumption[hour + 2] + data.consumption[hour + 3];
      deviation = prod / cons;
    } else {
      deviation = data.total_production / data.total_consumption;
    }

    if (!isFinite(deviation)){
      deviation = 0;
    }

    return Math.floor(deviation * 100);
  };
  
  return daily;
}