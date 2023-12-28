/**
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
import {
  getNumberFormatter,
  GenericDataType,
  extractTimegrain,
  QueryFormData,
  getMetricLabel,
} from '@superset-ui/core';
import {
  ColorFormatters,
  getColorFormatters,
} from '@superset-ui/chart-controls';
import { ConditionalBigNumberTotalChartProps } from '../types';
import { getDateFormatter } from '../utils';

export default function transformProps(
  chartProps: ConditionalBigNumberTotalChartProps,
) {
  const { width, height, queriesData, formData, rawFormData } = chartProps;
  const {
    headerFontSize,
    metric = 'value',
    subheader = '',
    subheaderFontSize,
    forceTimestampFormatting,
    timeFormat,
    yAxisFormat,
    // TODO SWIGGY: ADDITION
    conditionalFormatting,
    // TODO SWIGGY: ADDITION END
  } = formData;
  const { data = [], coltypes = [] } = queriesData[0];
  const granularity = extractTimegrain(rawFormData as QueryFormData);
  const formattedSubheader = subheader;

  // const metricName = typeof metric === 'string' ? metric : metric.label;
  const metricName = getMetricLabel(metric);
  const bigNumber = data.length === 0 ? null : data[0][metricName];

  let metricEntry;
  if (chartProps.datasource && chartProps.datasource.metrics) {
    metricEntry = chartProps.datasource.metrics.find(
      metricItem => metricItem.metric_name === metric,
    );
  }

  const formatTime = getDateFormatter(
    timeFormat,
    granularity,
    metricEntry?.d3format,
  );

  const headerFormatter =
    coltypes[0] === GenericDataType.TEMPORAL ||
    coltypes[0] === GenericDataType.STRING ||
    forceTimestampFormatting
      ? formatTime
      : getNumberFormatter(yAxisFormat ?? metricEntry?.d3format ?? undefined); // TODO SWIGGY: UPDATION

  // TODO SWIGGY: ADDITION
  const defaultColorFormatters = [] as ColorFormatters;
  const colorThresholdFormatters =
    getColorFormatters(conditionalFormatting, data) ?? defaultColorFormatters;
  // TODO SWIGGY: ADDITION END

  return {
    width,
    height,
    bigNumber,
    headerFormatter,
    headerFontSize,
    subheaderFontSize,
    subheader: formattedSubheader,
    // TODO SWIGGY: ADDITION
    colorThresholdFormatters,
    // TODO SWIGGY: ADDITION-END
  };
}
