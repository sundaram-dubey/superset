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

// TODO: SWIGGY
export default function transformProps(chartProps: any) {
  const { width, height, queriesData, formData } = chartProps;
  const {
    groupby = [],
    metric,
    labelColor,
    chartColorOption,
    labelFontSize,
    outerRadius,
    contentColor,
    minVal,
    maxVal,
    startAngle,
    endAngle,
    chartColor,
    fontSize,
    valueFormatter,
    labelControlOffset,
    pointerControlOffset,
    contentFontSize,
    showPointer,
    showAxisTick,
    showSplitLine,
    splitNumber,
    showProgress,
    pointerColor,
    roundCap,
    radius,
    chartWidth,
    labelFontWeight,
    labelDistance,
    marginTop,
  } = formData;
  const { data = [] } = queriesData[0];

  const finalData: any = [];
  if (data.length > 0) {
    const keys = Object.keys(data[0]);
    const nonGroupByKeys = keys.filter(key => !groupby.includes(key));
    const keyNotInGroup = nonGroupByKeys[0];
    // iterate over data and get values for keyNotInGroup key and push it to finalData as json {'value': 123}
    data.forEach((item: any) => {
      const dataValue = item[keyNotInGroup];
      finalData.push({ value: dataValue });
    });
  }

  return {
    width,
    height,
    // UPDATION
    groupby,
    data,
    labelColor,
    chartColorOption,
    labelFontSize,
    outerRadius,
    contentColor,
    metric,
    minVal,
    maxVal,
    startAngle,
    endAngle,
    chartColor,
    fontSize,
    valueFormatter,
    labelControlOffset,
    pointerControlOffset,
    contentFontSize,
    showPointer,
    showAxisTick,
    showSplitLine,
    splitNumber,
    showProgress,
    roundCap,
    finalData,
    pointerColor,
    radius,
    chartWidth,
    labelFontWeight,
    labelDistance,
    marginTop,
  };
}
