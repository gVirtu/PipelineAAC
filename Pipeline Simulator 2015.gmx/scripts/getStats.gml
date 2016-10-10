with (obj_workspace) {
    if (instrNum>0) {
        global.rtypenum=0;
        global.branchnum=0;
        global.lwnum=0;
        global.swnum=0;
        global.othernum=0;
        global.cyclenum=0;
        var maxx=0, mccpi;
        with(obj_stage) {
            if (x>maxx) maxx=x;
        }
        global.cyclenum = ceil((maxx-vb_x)/ssep);
        for(i=0;i<instrNum;++i) {
            if (string_upper(string_copy(instrs[i],1,2)) == "LW") ++global.lwnum;
            else if (string_upper(string_copy(instrs[i],1,2)) == "SW") ++global.swnum;
            else if (string_upper(string_copy(instrs[i],1,3)) == "BEQ") ++global.branchnum;
            else if (string_upper(string_copy(instrs[i],1,3)) == "ADD" ||
                     string_upper(string_copy(instrs[i],1,3)) == "SUB" ||
                     string_upper(string_copy(instrs[i],1,3)) == "SLT" ||
                     string_upper(string_copy(instrs[i],1,3)) == "AND" ||
                     string_upper(string_copy(instrs[i],1,2)) == "OR") ++global.rtypenum;
            else ++global.othernum;
        }
        mccpi = ((global.lwnum*5)+((global.swnum+global.rtypenum)*4)+(global.branchnum*3))/instrNum;
        show_message_async( "Número de ciclos detectado : "+string(global.cyclenum)+
                            "#Número total de instruções : "+string(instrNum)+
                            "# Número de LOADs (5 ciclos úteis) : "+string(global.lwnum)+
                            "# Número de STOREs (4 ciclos úteis) : "+string(global.swnum)+
                            "# Número de instrs TIPO R (4 ciclos úteis) : "+string(global.rtypenum)+
                            "# Número de BRANCHES condicionais (3 ciclos úteis) : "+string(global.branchnum)+
                            "# Número de outras instruções (não contabilizadas) : "+string(global.othernum)+
                            "#Média de Ciclos por Instrução (pipeline) : "+string(global.cyclenum)+"/"+string(instrNum)+" = "+string(global.cyclenum/instrNum)+
                            "#Média de Ciclos por Instrução (multiciclo) : (("+string(global.lwnum)+"*5)+("+string(global.swnum+global.rtypenum)+"*4)+("+string(global.branchnum)+"*3))/"+string(instrNum)+" = "+string(mccpi)+
                            "##OBS: São contabilizadas apenas as instruções LW, SW, ADD, SUB, SLT, AND, OR e BEQ.");
    } else {
        show_message_async("..Cadê as instruções?");
    }
}
