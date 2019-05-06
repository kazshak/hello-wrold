-- SQL query for genview
SELECT [cstmRunResults].[(RunData) FiscalYear] AS [FiscalYear],
  CASE WHEN (([cstmRunResults].[(Variables) VariableDisplayName]='CAPACITY @PEAKHR')
       OR ([cstmRunResults].[(Variables) VariableDisplayName]='PEAKCAP @PEAKHR')
       OR ([cstmRunResults].[(Variables) VariableDisplayName]='Peak Load'))
        THEN Max([cstmRunResults].[(RunData) OnPeakValue])
        ELSE Sum([cstmRunResults].[(RunData) OnPeakValue])
  END AS [OnPeakValue],
  CASE WHEN (([cstmRunResults].[(Variables) VariableDisplayName]='CAPACITY @PEAKHR')
       OR ([cstmRunResults].[(Variables) VariableDisplayName]='PEAKCAP @PEAKHR')
       OR ([cstmRunResults].[(Variables) VariableDisplayName]='Peak Load'))
        THEN Max([cstmRunResults].[(RunData) OffPeakValue])
        ELSE Sum([cstmRunResults].[(RunData) OffPeakValue])
  END AS [OffPeakValue],
  CASE WHEN (([cstmRunResults].[(Variables) VariableDisplayName]='CAPACITY @PEAKHR')
       OR ([cstmRunResults].[(Variables) VariableDisplayName]='PEAKCAP @PEAKHR')
       OR ([cstmRunResults].[(Variables) VariableDisplayName]='Peak Load'))
        THEN Max([cstmRunResults].[(RunData) AllValue])
        ELSE Sum([cstmRunResults].[(RunData) AllValue])
  END AS [AllValue],
  [cstmRunResults].[(Assets) AssetName] AS [AssetName],
  ([cstmRunResults].[(Variables) VariableDisplayName] + ' (' + [cstmRunResults].[(UnitOfMeasures) UnitOfMeasureInExport] + ')') AS [VariableDisplayName],
  [cstmRunResults].[(AssetGroups) AssetGroupName] AS [AssetGroupName],
  [Runs].[RunName] AS [RunName],
  [Sections].[SectionName] AS [SectionName]
FROM (
   SELECT [RunResults].[RunResultId] AS [(RunResults) RunResultId],
  [RunResults].[ProcessName] AS [(RunResults) ProcessName],
  [RunResults].[StudyIdentifier] AS [(RunResults) StudyIdentifier],
  [RunResults].[ExportUsername] AS [(RunResults) ExportUsername],
  [RunResults].[ExportDate] AS [(RunResults) ExportDate],
  [RunResults].[ImportUsername] AS [(RunResults) ImportUsername],
  [RunResults].[ImportDate] AS [(RunResults) ImportDate],
  [RunResults].[RunId] AS [(RunResults) RunId],
  [RunResults].[SectionId] AS [(RunResults) SectionId],
  [cstmRunData].[(RunData) RunResultId] AS [(RunData) RunResultId],
  [cstmRunData].[(RunData) Iteration] AS [(RunData) Iteration],
  [cstmRunData].[(RunData) FiscalYear] AS [(RunData) FiscalYear],
  [cstmRunData].[(RunData) OnPeakValue] AS [(RunData) OnPeakValue],
  [cstmRunData].[(RunData) OffPeakValue] AS [(RunData) OffPeakValue],
  [cstmRunData].[(RunData) AllValue] AS [(RunData) AllValue],
  [cstmRunData].[(Assets) AssetId] AS [(Assets) AssetId],
  [cstmRunData].[(Assets) AssetName] AS [(Assets) AssetName],
  [cstmRunData].[(Assets) AssetDisplayName] AS [(Assets) AssetDisplayName],
  [cstmRunData].[(Variables) VariableId] AS [(Variables) VariableId],
  [cstmRunData].[(Variables) VariableDisplayName] AS [(Variables) VariableDisplayName],
  [cstmRunData].[(Variables) VariableDescription] AS [(Variables) VariableDescription],
  [cstmRunData].[(Variables) VariableNameInExport] AS [(Variables) VariableNameInExport],
  [cstmRunData].[(Variables) Formula] AS [(Variables) Formula],
  [cstmRunData].[(Variables) VariableTypeId] AS [(Variables) VariableTypeId],
  [cstmRunData].[(TimeGranularities) TimeGranularityId] AS [(TimeGranularities) TimeGranularityId],
  [cstmRunData].[(TimeGranularities) TimeGranularity] AS [(TimeGranularities) TimeGranularity],
  [cstmRunData].[(UnitOfMeasures) UnitOfMeasureId] AS [(UnitOfMeasures) UnitOfMeasureId],
  [cstmRunData].[(UnitOfMeasures) UnitOfMeasure] AS [(UnitOfMeasures) UnitOfMeasure],
  [cstmRunData].[(UnitOfMeasures) UnitOfMeasureInExport] AS [(UnitOfMeasures) UnitOfMeasureInExport],
  [cstmRunData].[(AggregationTypes) AggregationTypeId] AS [(AggregationTypes) AggregationTypeId],
  [cstmRunData].[(AggregationTypes) AggregationType] AS [(AggregationTypes) AggregationType],
  [cstmRunData].[(AssetGroups) AssetGroupId] AS [(AssetGroups) AssetGroupId],
  [cstmRunData].[(AssetGroups) AssetGroupCollectionId] AS [(AssetGroups) AssetGroupCollectionId],
  [cstmRunData].[(AssetGroups) AssetGroupName] AS [(AssetGroups) AssetGroupName],
  [cstmRunData].[(AssetGroups) Description] AS [(AssetGroups) Description]
   FROM [dbo].[RunResults] [RunResults]
  INNER JOIN (
   SELECT [RunData].[RunResultId] AS [(RunData) RunResultId],
    [RunData].[Iteration] AS [(RunData) Iteration],
    CASE WHEN Datepart(m, [RunData].[ValueDate]) > 9
         THEN Datepart(yyyy, [RunData].[ValueDate])+1
         ELSE Datepart(yyyy, [RunData].[ValueDate])
    END AS [(RunData) FiscalYear],
    [RunData].[OnPeakValue] AS [(RunData) OnPeakValue],
    [RunData].[OffPeakValue] AS [(RunData) OffPeakValue],
    [RunData].[AllValue] AS [(RunData) AllValue],
    [cstmAssetVariables].[(Assets) AssetId] AS [(Assets) AssetId],
    [cstmAssetVariables].[(Assets) SectionId] AS [(Assets) SectionId],
    [cstmAssetVariables].[(Assets) AssetName] AS [(Assets) AssetName],
    [cstmAssetVariables].[AssetDisplayName] AS [(Assets) AssetDisplayName],
    [cstmAssetVariables].[(Variables) VariableId] AS [(Variables) VariableId],
    [cstmAssetVariables].[(Variables) VariableDisplayName] AS [(Variables) VariableDisplayName],
    [cstmAssetVariables].[(Variables) VariableDescription] AS [(Variables) VariableDescription],
    [cstmAssetVariables].[(Variables) VariableNameInExport] AS [(Variables) VariableNameInExport],
    [cstmAssetVariables].[(Variables) Formula] AS [(Variables) Formula],
    [cstmAssetVariables].[(Variables) VariableTypeId] AS [(Variables) VariableTypeId],
    [cstmAssetVariables].[(TimeGranularities) TimeGranularityId] AS [(TimeGranularities) TimeGranularityId],
    [cstmAssetVariables].[(TimeGranularities) TimeGranularity] AS [(TimeGranularities) TimeGranularity],
    [cstmAssetVariables].[(UnitOfMeasures) UnitOfMeasureId] AS [(UnitOfMeasures) UnitOfMeasureId],
    [cstmAssetVariables].[(UnitOfMeasures) UnitOfMeasure] AS [(UnitOfMeasures) UnitOfMeasure],
    [cstmAssetVariables].[(UnitOfMeasures) UnitOfMeasureInExport] AS [(UnitOfMeasures) UnitOfMeasureInExport],
    [cstmAssetVariables].[(AggregationTypes) AggregationTypeId] AS [(AggregationTypes) AggregationTypeId],
    [cstmAssetVariables].[(AggregationTypes) AggregationType] AS [(AggregationTypes) AggregationType],
    [cstmAssetVariables].[(AssetGroups) AssetGroupId] AS [(AssetGroups) AssetGroupId],
    [cstmAssetVariables].[(AssetGroups) AssetGroupCollectionId] AS [(AssetGroups) AssetGroupCollectionId],
    [cstmAssetVariables].[(AssetGroups) AssetGroupName] AS [(AssetGroups) AssetGroupName],
    [cstmAssetVariables].[(AssetGroups) Description] AS [(AssetGroups) Description]
   FROM [dbo].[RunData] [RunData]
    INNER JOIN (
     SELECT [Assets].[AssetId] AS [(Assets) AssetId],
     [Assets].[SectionId] AS [(Assets) SectionId],
     [Assets].[AssetName] AS [(Assets) AssetName],
     [Assets].[AssetDisplayName] AS [AssetDisplayName],
     [cstmVariables].[(Variables) VariableId] AS [(Variables) VariableId],
     [cstmVariables].[(Variables) VariableDisplayName] AS [(Variables) VariableDisplayName],
     [cstmVariables].[(Variables) VariableDescription] AS [(Variables) VariableDescription],
     [cstmVariables].[(Variables) VariableNameInExport] AS [(Variables) VariableNameInExport],
     [cstmVariables].[(Variables) Formula] AS [(Variables) Formula],
     [cstmVariables].[(Variables) VariableTypeId] AS [(Variables) VariableTypeId],
     [cstmVariables].[(TimeGranularities) TimeGranularityId] AS [(TimeGranularities) TimeGranularityId],
     [cstmVariables].[(TimeGranularities) TimeGranularity] AS [(TimeGranularities) TimeGranularity],
     [cstmVariables].[(UnitOfMeasures) UnitOfMeasureId] AS [(UnitOfMeasures) UnitOfMeasureId],
     [cstmVariables].[(UnitOfMeasures) UnitOfMeasure] AS [(UnitOfMeasures) UnitOfMeasure],
     [cstmVariables].[(UnitOfMeasures) UnitOfMeasureInExport] AS [(UnitOfMeasures) UnitOfMeasureInExport],
     [cstmVariables].[(AggregationTypes) AggregationTypeId] AS [(AggregationTypes) AggregationTypeId],
     [cstmVariables].[(AggregationTypes) AggregationType] AS [(AggregationTypes) AggregationType],
     [cstmAssetGroups].[(AssetGroups) AssetGroupId] AS [(AssetGroups) AssetGroupId],
     [cstmAssetGroups].[(AssetGroups) AssetGroupCollectionId] AS [(AssetGroups) AssetGroupCollectionId],
     [cstmAssetGroups].[(AssetGroups) AssetGroupName] AS [(AssetGroups) AssetGroupName],
     [cstmAssetGroups].[(AssetGroups) Description] AS [(AssetGroups) Description]
     FROM [dbo].[Assets] [Assets]
     INNER JOIN (
      SELECT [Variables].[VariableId] AS [(Variables) VariableId],
       [Variables].[SectionId] AS [(Variables) SectionId],
       [Variables].[VariableDisplayName] AS [(Variables) VariableDisplayName],
       [Variables].[VariableDescription] AS [(Variables) VariableDescription],
       [Variables].[VariableNameInExport] AS [(Variables) VariableNameInExport],
       [Variables].[Formula] AS [(Variables) Formula],
       [Variables].[VariableTypeId] AS [(Variables) VariableTypeId],
       [TimeGranularities].[TimeGranularityId] AS [(TimeGranularities) TimeGranularityId],
       [TimeGranularities].[TimeGranularity] AS [(TimeGranularities) TimeGranularity],
       [UnitOfMeasures].[UnitOfMeasureId] AS [(UnitOfMeasures) UnitOfMeasureId],
       [UnitOfMeasures].[UnitOfMeasure] AS [(UnitOfMeasures) UnitOfMeasure],
       [UnitOfMeasures].[UnitOfMeasureInExport] AS [(UnitOfMeasures) UnitOfMeasureInExport],
       [AggregationTypes].[AggregationTypeId] AS [(AggregationTypes) AggregationTypeId],
       [AggregationTypes].[AggregationType] AS [(AggregationTypes) AggregationType]
      FROM [dbo].[Variables] [Variables]
       INNER JOIN [dbo].[TimeGranularities] [TimeGranularities] ON ([Variables].[TimeGranularityId] = [TimeGranularities].[TimeGranularityId])
       INNER JOIN [dbo].[UnitOfMeasures] [UnitOfMeasures] ON ([Variables].[UnitOfMeasureId] = [UnitOfMeasures].[UnitOfMeasureId])
       INNER JOIN [dbo].[AggregationTypes] [AggregationTypes] ON ([Variables].[AggregationTypeId] = [AggregationTypes].[AggregationTypeId])
     ) [cstmVariables] ON ([Assets].[SectionId] = [cstmVariables].[(Variables) SectionId])
     LEFT JOIN (
      SELECT [AssetGroupsAssets].[AssetId] AS [(AssetGroupsAssets) AssetId],
       [AssetGroups].[AssetGroupId] AS [(AssetGroups) AssetGroupId],
       [AssetGroups].[AssetGroupCollectionId] AS [(AssetGroups) AssetGroupCollectionId],
       [AssetGroups].[AssetGroupName] AS [(AssetGroups) AssetGroupName],
       [AssetGroups].[Description] AS [(AssetGroups) Description]
      FROM [dbo].[AssetGroupsAssets] [AssetGroupsAssets]
       INNER JOIN [dbo].[AssetGroups] [AssetGroups] ON ([AssetGroupsAssets].[AssetGroupId] = [AssetGroups].[AssetGroupId])
     ) [cstmAssetGroups] ON ([Assets].[AssetId] = [cstmAssetGroups].[(AssetGroupsAssets) AssetId])
    ) [cstmAssetVariables] ON (([RunData].[VariableId] = [cstmAssetVariables].[(Variables) VariableId]) AND ([RunData].[AssetId] = [cstmAssetVariables].[(Assets) AssetId]))
  ) [cstmRunData] ON (([RunResults].[RunResultId] = [cstmRunData].[(RunData) RunResultId]) AND ([RunResults].[SectionId] = [cstmRunData].[(Assets) SectionId]) AND ([RunResults].[TimeGranularityId] = [cstmRunData].[(TimeGranularities) TimeGranularityId]))
 ) [cstmRunResults]
  INNER JOIN [dbo].[Runs] [Runs] ON ([cstmRunResults].[(RunResults) RunId] = [Runs].[RunId])
  INNER JOIN [dbo].[Sections] [Sections] ON ([cstmRunResults].[(RunResults) SectionId] = [Sections].[SectionId])
  WHERE (
      ([cstmRunResults].[(TimeGranularities) TimeGranularityId] = 1) 
    AND (([Sections].[SectionId] = 1) OR ([Sections].[SectionId] = 3))
    AND (([Runs].[RunId] = _____))
    AND (([cstmRunResults].[(AssetGroups) AssetGroupCollectionId] = 1) OR ([cstmRunResults].[(AssetGroups) AssetGroupCollectionId] IS NULL))
 )
  GROUP BY 
  [cstmRunResults].[(RunData) FiscalYear],
  [cstmRunResults].[(Assets) AssetName],
  [cstmRunResults].[(Variables) VariableDisplayName],
  [cstmRunResults].[(AssetGroups) AssetGroupName],
  [cstmRunResults].[(UnitOfMeasures) UnitOfMeasureInExport],
  [Runs].[RunName],
  [Sections].[SectionName]