// TODO: SWIGGY
import styled from '@emotion/styled';
import * as echarts from 'echarts';
import React, { useEffect, useRef } from 'react';
import { EChartsOption } from 'echarts';
import 'echarts/lib/chart/gauge';
import 'echarts/lib/component/tooltip';
import 'echarts/lib/component/title';

type CustomGaugeChartProps = {
  groupby: any;
  metric: any;
  labelColor: any;
  chartColorOption: any;
  labelFontSize: any;
  outerRadius: any;
  contentColor: any;
  minVal: any;
  maxVal: any;
  startAngle: any;
  endAngle: any;
  chartColor: any;
  fontSize: any;
  valueFormatter: any;
  labelControlOffset: any;
  pointerControlOffset: any;
  contentFontSize: any;
  showPointer: any;
  showAxisTick: any;
  showSplitLine: any;
  splitNumber: any;
  showProgress: any;
  roundCap: any;
  finalData: any;
  pointerColor: any;
  radius: any;
  chartWidth: any;
  labelFontWeight: any;
  labelDistance: any;
  height: any;
  marginTop: any;
};

interface GaugeChartProps {
  options: EChartsOption;
}
const GaugeChart: React.FC<GaugeChartProps> = ({ options }) => {
  const chartRef = useRef<HTMLDivElement>(null);

  const option = options;
  useEffect(() => {
    const myChart = echarts.init(chartRef.current!);

    if (option) {
      myChart.setOption(option);
    }

    // Clean up the chart when the component unmounts
    return () => {
      myChart.dispose();
    };
  }, [option]);

  return <div ref={chartRef} style={{ width: '100%', height: '400px' }} />;
};

class CustomGaugeChartViz extends React.PureComponent<CustomGaugeChartProps> {
  render() {
    const {
      labelColor,
      labelFontSize,
      contentColor,
      minVal,
      maxVal,
      startAngle,
      endAngle,
      chartColor,
      valueFormatter,
      labelControlOffset,
      pointerControlOffset,
      contentFontSize,
      showPointer,
      showAxisTick,
      showSplitLine,
      splitNumber,
      roundCap,
      finalData,
      pointerColor,
      radius,
      chartWidth,
      labelFontWeight,
      labelDistance,
      showProgress,
      marginTop,
    } = this.props;

    const option: EChartsOption = {
      series: [
        {
          type: 'gauge',
          startAngle,
          endAngle,
          min: minVal,
          max: maxVal,
          splitNumber,
          radius,
          itemStyle: {
            color: chartColor,
            shadowColor: 'grey',
            shadowBlur: 5,
            shadowOffsetX: 2,
            shadowOffsetY: 2,
          },
          progress: {
            show: showProgress,
            roundCap,
            width: chartWidth,
          },
          pointer: showPointer
            ? {
                itemStyle: {
                  color: pointerColor,
                },
                offsetCenter: [0, `${pointerControlOffset}%`],
              }
            : {
                show: false,
              },
          axisLine: {
            roundCap,
            lineStyle: {
              width: chartWidth,
            },
          },
          axisTick: !showAxisTick
            ? { show: false }
            : {
                splitNumber: 2,
                lineStyle: {
                  width: 2,
                  color: '#999',
                },
              },
          splitLine: !showSplitLine
            ? { show: false }
            : {
                length: 12,
                lineStyle: {
                  width: 3,
                  color: '#999',
                },
              },
          axisLabel: {
            distance: labelDistance,
            color: labelColor,
            fontSize: labelFontSize,
            fontWeight: labelFontWeight,
          },
          title: {
            show: false,
          },
          detail: {
            offsetCenter: [10, `${labelControlOffset}%`],
            valueAnimation: true,
            formatter: value => {
              if (value % 1 === 0) {
                return `${value.toFixed(0)}${valueFormatter}`;
              }
              return `${value.toFixed(2)}${valueFormatter}`;
            },
            color: contentColor,
            fontSize: contentFontSize,
          },
          data: finalData,
        },
      ],
    };

    return (
      <div style={{ marginTop }}>
        <GaugeChart options={option} />
      </div>
    );
  }
}
export default styled(CustomGaugeChartViz)`
  position: relative;
  display: flex;
  flex-direction: column;
  justify-content: center;
`;
