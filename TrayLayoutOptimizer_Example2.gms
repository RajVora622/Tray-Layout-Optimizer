*4-PASS TRAY LAYOUT OPTIMIZER - EXAMPLE 1*

set Panel/S1*S4/   ;
set Downcomer /SDC, OCDC, CDC/  ;



variables z;
variables sideDCAreaPercentage, DCTotalArea, DCArea(Downcomer) , DCAreaD(Downcomer), DCAreaTheta(Downcomer), DCCordWidth(Downcomer), DCBottomCordWidth(Downcomer),
          DCCordPosLeft(Downcomer), DCCordPosRight(Downcomer), DCCordPosFromCenterRight(Downcomer)  ,DCCordPosFromCenterLeft(Downcomer),
          DCCordThetaLeft(Downcomer), DCCordThetaRight(Downcomer), DCCordLeftArea(Downcomer), DCCordRightArea(Downcomer),
          OCDCCentralAxis  , Slope,
          PanLeftCordPos(Panel), PanRightCordPos(Panel),PanArea(Panel),  PanAreaPosFromCenterLeft(Panel),  PanAreaPosFromCenterRight(Panel),
          PanAreaThetaLeft(Panel), PanAreaThetaRight(Panel), PanAreaLeftArea(Panel), PanAreaRightArea(Panel)
          ;


*Initializations and bounds

sideDCAreaPercentage.lo = 20;
sideDCAreaPercentage.up = 49;
sideDCAreaPercentage.l = 23;

scalars  R /1250/ ;

DCCordWidth.fx("SDC")=300;
Slope.fx=80;

PanArea.LO(Panel) = 0.01;
DCCordWidth.LO(Downcomer)=0.01;



equations SDCArea_Eq1, SDCArea_Eq2, SDCAreaCalculation , DCTotalAreaAssign, CDCAreaAssign,OCDCAreaAssign     , CDCCordWidth_Eq1 ,
CDCCordWidth_Eq2 ,CDCCordWidth_Eq3,CDCCordWidth_Eq4,CDCCordWidth_Eq5,CDCCordWidth_Eq6,CDCCordWidth_Eq7,CDCCordWidth_Eq8, CDCCordWidth_Eq9,  EqualFPLConstraint,
 OCDCCordWidth_Eq1 ,OCDCCordWidth_Eq2 ,OCDCCordWidth_Eq3,OCDCCordWidth_Eq4,OCDCCordWidth_Eq5,OCDCCordWidth_Eq6,OCDCCordWidth_Eq7,OCDCCordWidth_Eq8, OCDCCordWidth_Eq9,
 AmountOfSlopeWidth, Sloping_Eq1, Sloping_Eq2,
Panel_S1_eq1,
Panel_S1_eq2,Panel_S2_eq1,Panel_S2_eq2,Panel_S3_eq1,Panel_S3_eq2,Panel_S4_eq1,Panel_S4_eq2,
PanelArea_eq1, PanelArea_eq2(Panel) , PanelArea_eq3(Panel), PanelArea_eq4(Panel), PanelArea_eq5(Panel), PanelArea_eq6(Panel), PanelArea_eq7(Panel),

obj;

z.lo=0;

obj.. z =e= 0.5*((sideDCAreaPercentage/(50-sideDCAreaPercentage))-(PanArea("S1")/PanArea("S2"))) + 0.5 * ((sideDCAreaPercentage/(50-sideDCAreaPercentage))-(PanArea("S3")/PanArea("S4")));



* Side Downcomer Area Calculation

SDCArea_Eq1.. DCAreaD("SDC") =e= R - DCCordWidth("SDC");
SDCArea_Eq2.. DCAreaTheta("SDC") =e= 2*arccos(DCAreaD("SDC")/R);
SDCAreaCalculation.. DCArea("SDC") =e= ((R**2)/2) * ( DCAreaTheta("SDC") - sin (DCAreaTheta("SDC") ) );

* Downcomer Area Assignments

DCTotalAreaAssign..  DCTotalArea =e= DCArea("SDC") * 100 / sideDCAreaPercentage ;
CDCAreaAssign.. DCArea("CDC") =e=  2*(50-sideDCAreaPercentage)*DCTotalArea/100;
OCDCAreaAssign.. DCArea("OCDC") =e= 0.5*DCTotalArea;

*DCCordWidth.L("CDC")=150;

* Center Downcomer Cord Width Calculations

CDCCordWidth_Eq1.. DCCordPosLeft("CDC") =e= R-(DCCordWidth("CDC")/2.);
CDCCordWidth_Eq2.. DCCordPosRight("CDC") =e= R+(DCCordWidth("CDC")/2.);
CDCCordWidth_Eq3.. DCCordPosFromCenterLeft("CDC") =e= R-DCCordPosLeft("CDC");
CDCCordWidth_Eq4.. DCCordPosFromCenterRight("CDC") =e= R-DCCordPosRight("CDC");
CDCCordWidth_Eq5.. DCCordThetaLeft("CDC") =e= 2*arccos(DCCordPosFromCenterLeft("CDC")/R);
CDCCordWidth_Eq6.. DCCordThetaRight("CDC") =e= 2*arccos(DCCordPosFromCenterRight("CDC")/R);
CDCCordWidth_Eq7.. DCCordLeftArea("CDC") =e= ((R**2)/2)*(DCCordThetaLeft("CDC")-sin(DCCordThetaLeft("CDC"))) ;
CDCCordWidth_Eq8.. DCCordRightArea("CDC") =e=((R**2)/2)*(DCCordThetaRight("CDC")-sin(DCCordThetaRight("CDC"))) ;
CDCCordWidth_Eq9.. 0 =e= DCArea("CDC")- ( DCCordRightArea("CDC")-DCCordLeftArea("CDC") ) ;

* Equal Flow Path Length Constraint

EqualFPLConstraint.. OCDCCentralAxis =e= ((R - (DCCordWidth("CDC")/2) - DCCordWidth("SDC") )/2 ) + DCCordWidth("SDC");

* Off Center Downcomer Cord Width Calculations

OCDCCordWidth_Eq1.. DCCordPosLeft("OCDC") =e= OCDCCentralAxis-(DCCordWidth("OCDC")/2.);
OCDCCordWidth_Eq2.. DCCordPosRight("OCDC") =e= OCDCCentralAxis+(DCCordWidth("OCDC")/2.);
OCDCCordWidth_Eq3.. DCCordPosFromCenterLeft("OCDC") =e= R-DCCordPosLeft("OCDC");
OCDCCordWidth_Eq4.. DCCordPosFromCenterRight("OCDC") =e= R-DCCordPosRight("OCDC");
OCDCCordWidth_Eq5.. DCCordThetaLeft("OCDC") =e= 2*arccos(DCCordPosFromCenterLeft("OCDC")/R);
OCDCCordWidth_Eq6.. DCCordThetaRight("OCDC") =e= 2*arccos(DCCordPosFromCenterRight("OCDC")/R);
OCDCCordWidth_Eq7.. DCCordLeftArea("OCDC") =e= ((R**2)/2)*(DCCordThetaLeft("OCDC")-sin(DCCordThetaLeft("OCDC"))) ;
OCDCCordWidth_Eq8.. DCCordRightArea("OCDC") =e=((R**2)/2)*(DCCordThetaRight("OCDC")-sin(DCCordThetaRight("OCDC"))) ;
OCDCCordWidth_Eq9.. 0 =e= DCArea("OCDC")- ( DCCordRightArea("OCDC")-DCCordLeftArea("OCDC") ) ;

* Sloping Considerations

AmountOfSlopeWidth..  Slope =e= DCCordWidth("SDC")-DCBottomCordWidth("SDC");

Sloping_Eq1.. DCBottomCordWidth("CDC") =e= DCCordWidth("CDC")-2*Slope;
Sloping_Eq2.. DCBottomCordWidth("OCDC") =e= DCCordWidth("OCDC")-2*Slope;

* Tray Panel Calculations

Panel_S1_eq1.. PanLeftCordPos("S1") =e= DCCordWidth("SDC");
Panel_S1_eq2.. PanRightCordPos("S1") =e= OCDCCentralAxis-DCBottomCordWidth("OCDC")/2;

Panel_S2_eq1.. PanLeftCordPos("S2") =e= OCDCCentralAxis+DCBottomCordWidth("OCDC")/2;
Panel_S2_eq2.. PanRightCordPos("S2") =e= R- DCCordWidth("CDC")/2;

Panel_S3_eq1.. PanLeftCordPos("S3") =e= DCBottomCordWidth("SDC");
Panel_S3_eq2.. PanRightCordPos("S3") =e= OCDCCentralAxis - DCCordWidth("OCDC")/2;

Panel_S4_eq1.. PanLeftCordPos("S4") =e= OCDCCentralAxis + DCCordWidth("OCDC")/2;
Panel_S4_eq2.. PanRightCordPos("S4") =e= R- DCBottomCordWidth("CDC")/2;

PanelArea_eq1(Panel).. PanAreaPosFromCenterLeft(Panel) =e= R - PanLeftCordPos(Panel);
PanelArea_eq2(Panel).. PanAreaPosFromCenterRight(Panel) =e= R - PanRightCordPos(Panel);
PanelArea_eq3(Panel).. PanAreaThetaLeft(Panel) =e= 2*arccos(PanAreaPosFromCenterLeft(Panel)/R);
PanelArea_eq4(Panel).. PanAreaThetaRight(Panel) =e= 2*arccos(PanAreaPosFromCenterRight(Panel)/R);
PanelArea_eq5(Panel).. PanAreaLeftArea(Panel) =e= (R*R/2) * (PanAreaThetaLeft(Panel) - sin(PanAreaThetaLeft(Panel)) );
PanelArea_eq6(Panel).. PanAreaRightArea(Panel) =e= (R*R/2) * (PanAreaThetaRight(Panel) - sin(PanAreaThetaRight(Panel)) );

PanelArea_eq7(Panel).. PanArea(Panel) =e= PanAreaRightArea(Panel) - PanAreaLeftArea(Panel) ;



model xyz /all/;

solve xyz using NLP minimizing z;

* Further Analysis

scalar DCCordLength_SDC,DCCordLength_CDC,DCCordLength_OCDCInbound,DCCordLength_OCDCOutbound
         DCWeirLength_SDC,DCWeirLength_CDC,DCWeirLength_OCDCInbound,DCWeirLength_OCDCOutbound
         ;


DCCordLength_SDC=((R-DCCordWidth.L("SDC")/2)*8*DCCordWidth.L("SDC"))**0.5;
DCCordLength_CDC = (((R-PanRightCordPos.L("S2")/2)*8*PanRightCordPos.L("S2"))**0.5)*2;
DCCordLength_OCDCInbound= ((R-PanLeftCordPos.L("S4")/2)*8*PanLeftCordPos.L("S4"))**0.5;
DCCordLength_OCDCOutbound = ((R-PanRightCordPos.L("S3")/2)*8*PanRightCordPos.L("S3"))**0.5;

DCWeirLength_SDC = DCCordLength_SDC;
DCWeirLength_OCDCInBound=DCCordLength_OCDCInBound;
DCWeirLength_OCDCOutBound= DCCordLength_OCDCInBound*(DCArea.L("SDC")/(DCArea.L("CDC")/2));
DCWeirLength_CDC=DCCordLength_SDC*(DCArea.L("CDC")/DCArea.L("SDC"));


Display sideDCAreaPercentage.L ;
Display DCCordWidth.L;
Display DCBottomCordWidth.L;
Display DCCordLength_SDC,DCCordLength_CDC,DCCordLength_OCDCInbound,DCCordLength_OCDCOutbound;
Display DCWeirLength_SDC,DCWeirLength_CDC,DCWeirLength_OCDCInbound,DCWeirLength_OCDCOutbound ;
Display OCDCCentralAxis.L;


