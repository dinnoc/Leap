use LeaPDev

Select RR.TPCOrderNo, RR.BatchNumber,RR.EndDate ,RR.nextEndDate ,RR.WorkCentreDesc ,TT.BatchID ,TT.TransDate,TT.TransactionID 
From 
(SELECT LeaP_Transactions.TransactionID, LeaP_Transactions.TransType, LeaP_Transactions.TransDate, LeaP_Transactions.Quantity, 
               LeaP_Transactions.BatchID, LeaP_Transactions.ItemCode, LeaP_Transactions.BatchIDTrim
FROM  LeaP_Transactions INNER JOIN
                   (SELECT MAX(TransType) AS tType, BatchIDTrim AS btrim
                    FROM   LeaP_Transactions AS LeaP_Transactions_1
                    GROUP BY BatchIDTrim) AS A ON A.tType = LeaP_Transactions.TransType AND A.btrim = LeaP_Transactions.BatchIDTrim) 
                    AS TT
inner join 
(SELECT LeaP_ShipPlanCom.TPCOrderNo, LeaP_spcBatches.BatchNumber,
LeaP_RouteData.WorkCentreID ,LeaP_RouteData .EndDate , LeaP_WorkCentre.WorkCentreDesc, 
LeaP_WorkCentre.WorkCentreCompleteTransaction,  LeaP_RouteData_1 .EndDate AS nextEndDate
FROM  LeaP_ShipPlanCom 
INNER JOIN LeaP_spcBatches ON LeaP_ShipPlanCom.spcID = LeaP_spcBatches.spcID
INNER JOIN LeaP_RouteData ON LeaP_RouteData .spcBatchID = LeaP_spcBatches .spcBatchID
INNER JOIN LeaP_WorkCentre ON LeaP_RouteData .WorkCentreID = LeaP_WorkCentre .WorkCentreID 
LEFT OUTER JOIN LeaP_RouteData as LeaP_RouteData_1 on (LeaP_RouteData.nextworkcentre = LeaP_RouteData_1.WorkCentreID 
				and  LeaP_RouteData .spcBatchID = LeaP_RouteData_1.spcBatchID)) AS RR
ON 
TT.BatchIDTrim =  RR.BatchNumber and TT.TransType = RR.WorkCentreCompleteTransaction

Order by RR.TPCOrderNo ,RR.BatchNumber ,TT.TransactionID



