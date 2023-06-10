function results = plothfeIcPNP(Vce, DAC1set, VceTopBreachAction, pathsNconsts, simulationVariables)
    arguments
        Vce                     double      {mustBeInRange(Vce,0,10)}
        DAC1set                 double      {mustBeNonempty, mustBePositive, mustBeInRange(DAC1set,0,4095)}
        VceTopBreachAction      string      {mustBeMember(VceTopBreachAction,["error", "return", "notice"])}
        pathsNconsts            struct
        simulationVariables     struct
    end
    assert(issorted(DAC1set));
    DAC1set = DAC1set(end:-1:1);

    CResNum = 0;
    setCRes(CResNum);
    results = {};
    setDAC1(4095);
    setEpwr(0);

%     findInitialDAC1();
%     DAC1set = cutDAC1set(DAC1set);

    for i=DAC1set
        setDAC1(i);
        msg = tuneToVce;
        if msg ~= "SUCCESS"
            results = cell2mat(results);
            return;
        end
        results{end+1} = simulate(pathsNconsts,simulationVariables); %#ok<AGROW> 
    end
    results = cell2mat(results);

    function result = tuneToVce()
        result = "SUCCESS";
        msg = tuneBy("Vce","DAC0",Vce,"direct",pathsNconsts,simulationVariables);
        if msg == "TOP BREACH" && CResNum == 0
            informLog(['TOP BREACH occured while trying to tune DAC0 for Vc=' num2str(Vce) ...
                '.Switching to Rc=10 Ohm']);
            setCRes(1);
            CResNum = 1;
            msg = tuneToVce();
        end
        if msg == "TOP BREACH" && CResNum == 1
            informLog(['the TOP BREACH for Vc=' num2str(Vce) ' repeated when Rc=10 Ohm']);
            result = "TOP BREACH";
            return;
        end
    end
end
