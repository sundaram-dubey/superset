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
import React from 'react';
import { Pie } from '@ant-design/plots';
import { styled } from '@superset-ui/core';

type HalfDonutChartProps = {
  width: any;
  height: any;
  // UPDATION
  colorScheme: any;
  donut: any;
  groupby: any;
  innerRadius: any;
  data: any;
  metric: any;
  labelType: any;
  labelColor: any;
  chartColorOption: any;
  showLabelsThreshold: any;
  labelFontSize: any;
  legendFontSize: any;
  outerRadius: any;
  chartContent: any;
  contentColor: any;
  chartHeight: any;
  chartTopMargin: any;
};

class HalfDonutChartViz extends React.PureComponent<HalfDonutChartProps> {
  getClassName() {
    return `superset-legacy-chart-pie-no-trendline`;
  }

  createTemporaryContainer() {
    const container = document.createElement('div');
    container.className = this.getClassName();
    container.style.position = 'absolute'; // so it won't disrupt page layout
    container.style.opacity = '0'; // and not visible
    return container;
  }

  render() {
    const {
      data,
      // showLabels,
      labelColor,
      // height,
      innerRadius,
      chartColorOption,
      labelFontSize,
      outerRadius,
      legendFontSize,
      chartContent,
      labelType,
      contentColor,
      chartHeight,
      chartTopMargin,
    } = this.props;

    // const outerRadiusWidth = outerRadius * (3 / 2);

    const keys = Object.keys(data[0]);
    const colorFieldKey = keys[0];
    const angleFieldKey = keys[1];

    const showLegend: any = false;

    const donutConfig = {
      data,
      angleField: angleFieldKey,
      colorField: colorFieldKey,
      color: chartColorOption.split(','),
      radius: outerRadius,
      innerRadius,
      startAngle: Math.PI,
      endAngle: Math.PI * 2,
      legend: showLegend,
      label: {
        type: labelType,
        offset: `${legendFontSize}%`,
        content: '{name} \n {value} ⁞ {percentage}',
        style: {
          fill: labelColor,
          fontSize: labelFontSize,
          fontWeight: 'bold',
          fontFamily: 'Arial',
        },
      },
      interactions: [
        {
          type: 'element-selected',
        },
        {
          type: 'element-active',
        },
      ],
      // style: { marginTop: `-165px` }, // to adjust the chart position on dashboard after testing
      statistic: {
        title: true,
        content: {
          style: {
            padding: `${chartContent}px`,
            color: contentColor,
          },
        },
      },
    };
    const className = this.getClassName();
    return (
      <div
        className={className}
        style={{
          height: `${chartHeight}px`,
          overflow: 'visible',
          marginTop: `${chartTopMargin}px`,
        }}
      >
        <Pie {...donutConfig} />
      </div>
    );
  }
}
export default styled(HalfDonutChartViz)`
  font-family: ${({ theme }) => theme.typography.families.sansSerif};
  position: relative;
  display: flex;
  flex-direction: column;
  justify-content: center;
`;
// dummy commit
