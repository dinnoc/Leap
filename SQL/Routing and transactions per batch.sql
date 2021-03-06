use LeaPDev
SELECT LeaP_ShipPlanCom.TPCOrderNo, LeaP_spcBatches.BatchNumber, LeaP_RouteData.WorkCentreID, LeaP_RouteData.StartDate, 
               LeaP_RouteData.EndDate, LeaP_WorkCentre.WorkCentreDesc, LeaP_Transactions .BatchID , 
               LeaP_Transactions.TransDate, LeaP_WorkCentre .WorkCentreCompleteTransaction, LeaP_Transactions.Quantity  
FROM  LeaP_ShipPlanCom 
Inner Join LeaP_spcBatches on LeaP_ShipPlanCom .spcID = LeaP_spcBatches .spcID
Inner Join LeaP_RouteData on LeaP_spcBatches .spcBatchID = Leap_routedata.spcBatchID
Inner Join LeaP_WorkCentre on LeaP_RouteData .WorkCentreID = LeaP_WorkCentre .WorkCentreID 
left outer join  LeaP_Transactions on LeaP_WorkCentre.WorkCentreCompleteTransaction = LeaP_Transactions.TransType and
(LeaP_spcBatches.BatchNumber = LeaP_Transactions.BatchIDTrim or LeaP_spcBatches.BatchTrimmed = LeaP_Transactions.BatchIDTrim)
   order by tpcorderno,BatchNumber, WorkCentreCompleteTransaction