use LeaPDev

SELECT TOP (100) PERCENT RR.spcID, RR.spcBatchID, RR.BatchNumber, RR.WorkCentreDesc, RR.EndDate,RR.BatchTrimmed , TT.TransDate, RR.nextWorkCentre, 
               RR.nextEndDate, TT.BatchID, TT.TransactionID
FROM  (SELECT dbo.LeaP_Transactions.TransactionID, dbo.LeaP_Transactions.TransType, dbo.LeaP_Transactions.TransDate, 
                              dbo.LeaP_Transactions.Quantity, dbo.LeaP_Transactions.BatchID, dbo.LeaP_Transactions.ItemCode, 
                              dbo.LeaP_Transactions.BatchIDTrim
               FROM   dbo.LeaP_Transactions INNER JOIN
                                  (SELECT MAX(TransType) AS tType, BatchIDTrim AS btrim
                                   FROM   dbo.LeaP_Transactions AS LeaP_Transactions_1
                                   GROUP BY BatchIDTrim) AS A ON A.tType = dbo.LeaP_Transactions.TransType AND A.btrim = dbo.LeaP_Transactions.BatchIDTrim) 
               AS TT INNER JOIN
                   (SELECT dbo.LeaP_ShipPlanCom.TPCOrderNo, dbo.LeaP_spcBatches.BatchNumber, dbo.LeaP_spcBatches.spcBatchID, dbo.LeaP_spcBatches.BatchTrimmed, 
                                   dbo.LeaP_spcBatches.spcID, dbo.LeaP_RouteData.WorkCentreID, dbo.LeaP_RouteData.EndDate, dbo.LeaP_WorkCentre.WorkCentreDesc, 
                                   dbo.LeaP_WorkCentre.WorkCentreCompleteTransaction, LeaP_RouteData_1.EndDate AS nextEndDate, 
                                   LeaP_Workcentre_1.WorkCentreDesc AS nextWorkCentre
                    FROM   dbo.LeaP_ShipPlanCom INNER JOIN
                                   dbo.LeaP_spcBatches ON dbo.LeaP_ShipPlanCom.spcID = dbo.LeaP_spcBatches.spcID INNER JOIN
                                   dbo.LeaP_RouteData ON dbo.LeaP_RouteData.spcBatchID = dbo.LeaP_spcBatches.spcBatchID INNER JOIN
                                   dbo.LeaP_WorkCentre ON dbo.LeaP_RouteData.WorkCentreID = dbo.LeaP_WorkCentre.WorkCentreID LEFT OUTER JOIN
                                   dbo.LeaP_RouteData AS LeaP_RouteData_1 ON dbo.LeaP_RouteData.nextWorkCentre = LeaP_RouteData_1.WorkCentreID AND 
                                   dbo.LeaP_RouteData.spcBatchID = LeaP_RouteData_1.spcBatchID LEFT OUTER JOIN
                                   dbo.LeaP_WorkCentre AS LeaP_Workcentre_1 ON LeaP_RouteData_1.WorkCentreID = LeaP_Workcentre_1.WorkCentreID) AS RR 
                                   ON (TT.BatchIDTrim = RR.BatchNumber or TT.BatchIDTrim = RR.BatchTrimmed) AND TT.TransType = RR.WorkCentreCompleteTransaction
ORDER BY RR.TPCOrderNo, RR.BatchNumber, TT.TransactionID