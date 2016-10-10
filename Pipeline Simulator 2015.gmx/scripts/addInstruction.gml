///addInstruction(str)
//To be called from obj_add
var str = argument0;
var iN = obj_workspace.instrNum;

//Consume empty spaces
var c=1;
while(string_char_at(str, c)==' ' && c<=string_length(str)) {
    ++c;
}
str = string_copy(str,c,string_length(str)-c+1);

if (string_length(str)<3) exit;
global.ultstring=str;
obj_workspace.delObjs[iN] = instance_create(x,y,obj_delete);
(obj_workspace.delObjs[iN]).n = iN;
//Create stages
var i;
for(i=0;i<obj_workspace.numStgs;++i) {
    with (instance_create(obj_workspace.vb_x+(obj_workspace.ssep*(0.5+i+iN)),obj_workspace.hb_y+(obj_workspace.ssep*(0.5+iN)),obj_stage)) {
        n = iN;
        sn = i;
        name = obj_workspace.stgName[i];
        if (name=="EX") { 
            sprite_index=spr_alu;
            rx = -19;
            ry = -8;
            sx = 19;
            sy = 0;
        } else {
            rx = 0;
            ry = -19;
            sx = 0;
            sy = 19;   
            if (name=="ID") { sprite_index = spr_readstage; }
            else if (name=="WB") { sprite_index = spr_writestage; }
        }
        if (string_upper(str)=="NOP") image_alpha=0.4;
    }
}
obj_workspace.instrs[obj_workspace.instrNum++]=str;
event_perform(ev_other,ev_user0);
