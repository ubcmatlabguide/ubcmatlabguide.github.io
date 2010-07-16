 function [xabs,yabs] = rel2abs(xpos,ypos)
    ax = gca;
    xlim = get(ax,'xlim')   ; ylim = get(ax,'ylim');
    xmin = xlim(1)          ; xmax = xlim(2);
    ymin = ylim(1)          ; ymax = ylim(2);
    xscale = xmax - xmin    ; yscale = ymax - ymin;
    axAbs = get(ax,'Position');
    xabs = axAbs(1) + ((xpos-xmin) ./ xscale).*axAbs(3);
    yabs = axAbs(2) + ((ypos-ymin) ./ yscale).*axAbs(4);
 end