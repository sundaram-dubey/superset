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
import React from 'react';
import {
  t,
  getNumberFormatter,
  NumberFormatter,
  smartDateVerboseFormatter,
  TimeFormatter,
  computeMaxFontSize,
  styled,
} from '@superset-ui/core';
// eslint-disable-next-line no-restricted-imports
import { ColorFormatters } from '@superset-ui/chart-controls';
import { TimeSeriesDatum } from './types';

const defaultNumberFormatter = getNumberFormatter();

const PROPORTION = {
  // text size: proportion of the chart container
  HEADER: 0.3,
  SUBHEADER: 0.125,
};

type ConditionalBigNumberTotalVisProps = {
  className?: string;
  width: number;
  height: number;
  bigNumber?: any;
  bigNumberFallback?: TimeSeriesDatum;
  headerFormatter: NumberFormatter | TimeFormatter;
  formatTime: TimeFormatter;
  headerFontSize: number;
  subheader: string;
  subheaderFontSize: number;
  // TODO SWIGGY: ADDITION
  colorThresholdFormatters?: ColorFormatters;
  // TODO SWIGGY: ADDITION
};

class ConditionalBigNumberTotalVis extends React.PureComponent<ConditionalBigNumberTotalVisProps> {
  static defaultProps = {
    className: '',
    headerFormatter: defaultNumberFormatter,
    formatTime: smartDateVerboseFormatter,
    headerFontSize: PROPORTION.HEADER,
    subheader: '',
    subheaderFontSize: PROPORTION.SUBHEADER,
  };

  getClassName() {
    const { className, bigNumberFallback } = this.props;
    const names = `superset-legacy-chart-big-number ${className} ${
      bigNumberFallback ? 'is-fallback-value' : ''
    }`;
    return `${names} no-trendline`;
  }

  createTemporaryContainer() {
    const container = document.createElement('div');
    container.className = this.getClassName();
    container.style.position = 'absolute'; // so it won't disrupt page layout
    container.style.opacity = '0'; // and not visible
    return container;
  }

  renderFallbackWarning() {
    const { bigNumberFallback, formatTime } = this.props;
    if (!bigNumberFallback) return null;
    return (
      <span
        className="alert alert-warning"
        role="alert"
        title={t(
          `Last available value seen on %s`,
          formatTime(bigNumberFallback[0]),
        )}
      >
        {t('Not up to date')}
      </span>
    );
  }

  renderHeader(maxHeight: number) {
    const {
      bigNumber,
      headerFormatter,
      width,
      colorThresholdFormatters,
    } = this.props;

    const hasThresholdColorFormatter =
      Array.isArray(colorThresholdFormatters) &&
      colorThresholdFormatters.length > 0;

    let numberColor = 'black';
    if (hasThresholdColorFormatter) {
      colorThresholdFormatters!.forEach(formatter => {
        const formatterResult = bigNumber
          ? formatter.getColorFromValue(bigNumber as number)
          : false;
        if (formatterResult) {
          numberColor = formatterResult;
        }
      });
    } else {
      numberColor = 'black';
    }

    const text =
      bigNumber === null
        ? t('No results')
        : typeof bigNumber === 'number'
        ? headerFormatter(bigNumber)
        : bigNumber;

    const container = this.createTemporaryContainer();
    document.body.append(container);
    const fontSize = computeMaxFontSize({
      text,
      maxWidth: width,
      maxHeight,
      className: 'header-line',
      container,
    });
    container.remove();

    return (
      <div
        className="header-line"
        style={{
          fontSize,
          height: maxHeight,
          color: numberColor,
        }}
      >
        {text}
      </div>
    );
  }

  renderSubheader(maxHeight: number) {
    const { subheader, width, bigNumberFallback } = this.props;
    let fontSize = 0;

    const NO_DATA_OR_HASNT_LANDED = t('No results');
    const NO_DATA = t(
      'Try applying different filters or ensuring your datasource has data',
    );
    let text = subheader;
    if (this.props.bigNumber === null) {
      text = bigNumberFallback ? NO_DATA : NO_DATA_OR_HASNT_LANDED;
    }
    if (text) {
      const container = this.createTemporaryContainer();
      document.body.append(container);
      fontSize = computeMaxFontSize({
        text,
        maxWidth: width,
        maxHeight,
        className: 'subheader-line',
        container,
      });
      container.remove();

      return (
        <div
          className="subheader-line"
          style={{
            fontSize,
            height: maxHeight,
          }}
        >
          {text}
        </div>
      );
    }
    return null;
  }

  render() {
    const { height, headerFontSize, subheaderFontSize } = this.props;
    const className = this.getClassName();

    return (
      <div className={className} style={{ height }}>
        {this.renderFallbackWarning()}
        {this.renderHeader(Math.ceil(headerFontSize * height))}
        {this.renderSubheader(Math.ceil(subheaderFontSize * height))}
      </div>
    );
  }
}

export default styled(ConditionalBigNumberTotalVis)`
  font-family: ${({ theme }) => theme.typography.families.sansSerif};
  position: relative;
  display: flex;
  flex-direction: column;
  justify-content: center;

  &.no-trendline .subheader-line {
    padding-bottom: 0.3em;
  }

  .text-container {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: flex-start;
    .alert {
      font-size: ${({ theme }) => theme.typography.sizes.s};
      margin: -0.5em 0 0.4em;
      line-height: 1;
      padding: 2px 4px 3px;
      border-radius: 3px;
    }
  }

  .kicker {
    font-weight: ${({ theme }) => theme.typography.weights.light};
    line-height: 1em;
    padding-bottom: 2em;
  }

  .header-line {
    font-weight: ${({ theme }) => theme.typography.weights.normal};
    position: relative;
    line-height: 1em;
    span {
      position: absolute;
      bottom: 0;
    }
  }

  .subheader-line {
    font-weight: ${({ theme }) => theme.typography.weights.light};
    line-height: 1em;
    padding-bottom: 0;
  }

  &.is-fallback-value {
    .kicker,
    .header-line,
    .subheader-line {
      opacity: 0.5;
    }
  }

  .superset-data-ui-tooltip {
    z-index: 1000;
    background: #000;
  }

  &.my-8 {
    margin-top: 8px;
    marfin-bottom: 8px;
  }
`;
