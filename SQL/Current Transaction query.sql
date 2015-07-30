SELECT LeaP_Transactions.TransactionID, LeaP_Transactions.TransType, LeaP_Transactions.TransDate, LeaP_Transactions.Quantity, 
               LeaP_Transactions.BatchID, LeaP_Transactions.ItemCode, LeaP_Transactions.BatchIDTrim, LeaP_WorkCentre.WorkCentreID
FROM  LeaP_Transactions INNER JOIN
                   (SELECT MAX(TransType) AS tType, BatchIDTrim AS btrim
                    FROM   LeaP_Transactions AS LeaP_Transactions_1
                    GROUP BY BatchIDTrim) AS A ON A.tType = LeaP_Transactions.TransType AND A.btrim = LeaP_Transactions.BatchIDTrim LEFT OUTER JOIN
               LeaP_WorkCentre ON A.tType = LeaP_WorkCentre.WorkCentreCompleteTransaction
ORDER BY LeaP_Transactions.BatchIDTrim
