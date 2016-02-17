$baseDim = 30.0;
$baseH = 1.0;
$thicknes = 1.0;
$H = 90.0;

//$fn = 50;

include <shapes.scad>

module makeSingle(base, heigh, thicknes){
    difference(){
        hexagon(base+thicknes, heigh);
        hexagon(base-thicknes, heigh);
    }
}

module makeSection(base, width, heigh) {
    intersection(){
        union(){
            for(i = [-2:2:2]){
                for(j = [-6:6]){
                    xTrans = (i*1.5/tan(60))*base;
                    yTrans = j*base;
                    translate([ xTrans, yTrans, 0 ])
                    makeSingle(base, $baseH, $thicknes);
                    xTrans1 = ((i+1)*1.5/tan(60))*base;
                    yTrans1 = (j+0.5)*base;
                    translate([ xTrans1, yTrans1, 0 ])
                    makeSingle(base, $baseH, $thicknes);
                }
            }
        };
        cube([width, heigh, 50], center=true);
    }
}

baseSize = $baseDim+$thicknes+0.5;
union(){
    
    union(){
        intersection(){
            makeSection(0.5*$baseDim, 2*$baseDim, 4*$baseDim);
            hexagon(baseSize, $baseH);
        };
        makeSingle(baseSize, $baseH, $thicknes);
    }
    
    for(i=[0:5]){
        rotate([0, 0, i*60])
        intersection(){
        //    hexagon(baseSize, $H+$thicknes*2);
            makeSingle(baseSize, $H+$thicknes*2, $thicknes);
            translate([0, -$thicknes/2, $thicknes/2])
            cube([baseSize, $thicknes, $H+$thicknes*2]);
        }
    }

    translate([0, 0, $H+$thicknes*2])
    makeSingle(baseSize, $baseH, $thicknes);
}