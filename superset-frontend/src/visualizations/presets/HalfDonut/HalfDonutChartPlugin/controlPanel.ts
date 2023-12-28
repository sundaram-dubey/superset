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
import { t, validateNonEmpty } from '@superset-ui/core';
import {
  ControlPanelConfig,
  sections,
  emitFilterControl,
} from '@superset-ui/chart-controls';

const innerRadius = 30;

const config: ControlPanelConfig = {
  controlPanelSections: [
    sections.legacyRegularTime,
    {
      label: t('Query'),
      expanded: true,
      controlSetRows: [
        ['groupby'],
        ['metric'],
        ['adhoc_filters'],
        emitFilterControl,
        ['row_limit'],
        [
          {
            name: 'sort_by_metric',
            config: {
              default: true,
              type: 'CheckboxControl',
              label: t('Sort by metric'),
              description: t(
                'Whether to sort results by the selected metric in descending order.',
              ),
            },
          },
        ],
      ],
    },
    {
      label: t('Chart Options'),
      expanded: true,
      controlSetRows: [
        [
          {
            name: 'chart_color_option',
            config: {
              type: 'TextControl',
              label: t('Chart Color Options'),
              renderTrigger: true,
              default: 'red,green,blue,yellow',
              description: t(
                'Enter comma seperated color names or hex values. Colors will be assigned on a round robin basis.',
              ),
            },
          },
        ],
        [
          {
            name: 'label_type',
            config: {
              type: 'TextControl',
              label: t('Label Type'),
              default: 'outer',
              renderTrigger: true,
              description: t(
                'Lables shoulf be shown inside or outside the pie chart?',
              ),
            },
          },
        ],
        [
          {
            name: 'label_color',
            config: {
              type: 'SelectControl',
              label: t('Label Color'),
              default: 'black',
              renderTrigger: true,
              choices: [
                ['red', 'Red'],
                ['white', 'White'],
                ['yellow', 'Yellow'],
                ['green', 'Green'],
                ['black', 'Black'],
              ],
              description: t('What should be color of the label?'),
            },
          },
        ],
        [
          {
            name: 'legend_font_size',
            config: {
              type: 'TextControl',
              label: t('Legend Offset'),
              renderTrigger: true,
              default: 100,
              description: t('Legend Offset'),
            },
          },
        ],
        [
          {
            name: 'label_font_size',
            config: {
              type: 'TextControl',
              label: t('Label Font Size'),
              renderTrigger: true,
              default: 5,
              description: t('Label Font Size'),
            },
          },
        ],
        [
          {
            name: 'chart_content',
            config: {
              type: 'TextControl',
              label: t('Chart Content Padding'),
              renderTrigger: true,
              default: 100,
              description: t('Padding of Text Inside Donut Chart'),
            },
          },
        ],
        [
          {
            name: 'chart_top_margin',
            config: {
              type: 'TextControl',
              label: t('Chart Top Margin'),
              renderTrigger: true,
              default: -100,
              description: t('Top margin of chart on dashboard'),
            },
          },
        ],
        [
          {
            name: 'chart_height',
            config: {
              type: 'TextControl',
              label: t('Chart Height'),
              renderTrigger: true,
              default: '400',
              description: t('Height of chart on dashboard'),
            },
          },
        ],
        [
          {
            name: 'content_color',
            config: {
              type: 'TextControl',
              label: t('Chart Content Color'),
              renderTrigger: true,
              default: 'black',
              description: t('Color of Text Inside Donut Chart'),
            },
          },
        ],
        [
          {
            name: 'outer_radius',
            config: {
              type: 'SliderControl',
              label: t('Outer Radius'),
              renderTrigger: true,
              min: 0.2,
              max: 4,
              step: 0.1,
              default: 0.3,
              description: t('Outer edge of Pie chart'),
            },
          },
        ],
        [
          {
            name: 'innerRadius',
            config: {
              type: 'SliderControl',
              label: t('Inner Radius'),
              renderTrigger: true,
              min: 0,
              max: 1,
              step: 0.1,
              default: innerRadius,
              description: t('Inner radius of donut hole'),
            },
          },
        ],
      ],
    },
  ],
  controlOverrides: {
    series: {
      validators: [validateNonEmpty],
      clearable: false,
    },
    row_limit: {
      default: 100,
    },
  },
};

export default config;
