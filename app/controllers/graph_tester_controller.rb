class GraphTesterController < ApplicationController
  
  $sample_points = {"date"=>"2012-11-10T00=>00=>00+01=>00","consumption"=>[182.51612903225808,185.55172413793105,183.71428571428572,243.82142857142858,253.7826086956522,253.23333333333332,332.92105263157896,255.27272727272728,254.36666666666667,212.67741935483872,177.12121212121212,181.51724137931035,207.13333333333333,254.12121212121212,254.0,253.96969696969697,254.79166666666666,254.525,254.12,180.0,180.84,184.1875,311.8484848484849,254.0,253.35135135135135,252.6,231.03030303030303,219.07692307692307,187.8684210526316,151.05555555555554,155.375,187.2,219.06451612903226,319.6333333333333,218.15625,279.44444444444446,300.2068965517241,337.79487179487177,279.6363636363636,316.8378378378378,273.8484848484849,300.35897435897436,281.09375,308.03225806451616,291.56756756756755,299.18918918918916,518.6,375.3783783783784,301.1034482758621,246.77777777777777,300.3611111111111,327.5357142857143,342.2758620689655,326.6060606060606,296.2647058823529,309.85714285714283,335.07894736842104,253.28571428571428,298.94871794871796,259.02702702702703,353.19444444444446,348.8536585365854,269.35,255.38235294117646,254.65853658536585,251.93333333333334,224.27586206896552,178.2439024390244,181.8684210526316,205.94285714285715,240.84848484848484,245.44736842105263,252.72972972972974,333.2439024390244,378.5833333333333,253.10344827586206,166.96428571428572,173.9189189189189,185.88095238095238,255.1891891891892,254.82857142857142,253.8095238095238,254.19230769230768,253.70967741935485,254.075,206.83783783783784,174.5,181.93478260869566,223.6216216216216,351.4782608695652,253.55555555555554,284.6666666666667,238.78571428571428,251.38235294117646,254.12820512820514,174.41379310344828],"production"=>[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.0,0.0,0.382,38.23511111111111,31.237555555555552,17.51511111111111,17.180111111111113,46.83088888888889,38.98166666666666,70.01188888888889,54.79611111111112,46.096,65.17966666666666,23.665555555555557,245.90155555555555,297.38455555555555,120.82844444444443,24.39811111111111,36.88433333333333,41.51477777777777,33.20033333333333,51.653777777777776,170.9181111111111,166.7181111111111,162.13366666666667,57.18222222222222,51.48766666666667,22.461222222222222,9.893888888888888,2.275444444444444,0.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],"deviation"=>[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0013669980119284293,0.12736253413992904,0.09247492535802844,0.06263531281606705,0.05422367236297119,0.17101021725498874,0.12978359228273859,0.2490695324563029,0.17789082044658544,0.15809714497589913,0.21785435109906656,0.04563354330033852,0.6550765033879729,0.9876491194584414,0.48962449347140924,0.0812292610746324,0.11261163813469996,0.12129040454921977,0.1016525329374652,0.17435008879623196,0.5516029404231341,0.49754874909465346,0.6401216394059034,0.19127769677216455,0.19877333750695605,0.06359449469130947,0.02836114412671778,0.008447909576552604,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0],"total_consumption"=>6147.272118827607,"total_production"=>486.23697222222216,"total_from_outside"=>5661.035146605385,"max_consumption"=>518.6,"max_production"=>297.38455555555555,"max_deviation"=>0.9876491194584414}
  
  
  def index
    
    respond_to do |format|
      format.html
      format.json { render :json => $sample_points }
    end
  end
end
