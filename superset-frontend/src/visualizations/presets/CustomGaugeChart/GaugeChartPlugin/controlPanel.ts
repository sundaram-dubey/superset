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
import { t, validateInteger, validateNonEmpty } from '@superset-ui/core';
import {
  ControlPanelConfig,
  sections,
  emitFilterControl,
} from '@superset-ui/chart-controls';

// const innerRadius = 30;

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
            name: 'min_val',
            config: {
              type: 'TextControl',
              isInt: true,
              default: String(0),
              validators: [validateNonEmpty, validateInteger],
              renderTrigger: true,
              label: t('Min'),
              description: t('Minimum value on the gauge axis'),
            },
          },
          {
            name: 'max_val',
            config: {
              type: 'TextControl',
              isInt: true,
              default: 100,
              validators: [validateNonEmpty, validateInteger],
              renderTrigger: true,
              label: t('Max'),
              description: t('Maximum value on the gauge axis'),
            },
          },
        ],
        [
          {
            name: 'start_angle',
            config: {
              type: 'TextControl',
              label: t('Start angle'),
              description: t('Angle at which to start progress axis'),
              renderTrigger: true,
              default: 180,
            },
          },
          {
            name: 'end_angle',
            config: {
              type: 'TextControl',
              label: t('End angle'),
              description: t('Angle at which to end progress axis'),
              renderTrigger: true,
              default: 0,
            },
          },
        ],
        [
          {
            name: 'chart_width',
            config: {
              type: 'TextControl',
              label: t('Progress width'),
              description: t('Width of the progress bar'),
              renderTrigger: true,
              default: 20,
            },
          },
          {
            name: 'chart_color',
            config: {
              type: 'TextControl',
              label: t('chart color'),
              description: t('Color of the gauge chart'),
              renderTrigger: true,
              default: 'teal',
            },
          },
          {
            name: 'radius',
            config: {
              type: 'TextControl',
              label: t('Chart Radius'),
              description: t('Outer radius of the gauge chart'),
              renderTrigger: true,
              default: 100,
            },
          },
        ],
        [
          {
            name: 'value_formatter',
            config: {
              type: 'TextControl',
              label: t('Value format'),
              description: t(
                'Additional text to add before or after the value, e.g. unit',
              ),
              renderTrigger: true,
              default: '{value}',
            },
          },
        ],
        [
          {
            name: 'label_color',
            config: {
              type: 'TextControl',
              label: t('label color'),
              description: t('What should be label color'),
              renderTrigger: true,
              default: 'black',
            },
          },
          {
            name: 'label_font_size',
            config: {
              type: 'TextControl',
              label: t('label size'),
              description: t('What should be label size?'),
              renderTrigger: true,
              default: '15',
            },
          },
          {
            name: 'label_font_weight',
            config: {
              type: 'TextControl',
              label: t('Label Font Weight'),
              description: t('Font weight of the label'),
              renderTrigger: true,
              default: 'bold',
            },
          },
          {
            name: 'label_distance',
            config: {
              type: 'SliderControl',
              label: t('Label distance'),
              description: t('What should be label distance from chart?'),
              renderTrigger: true,
              min: 0,
              max: 100,
              default: 20,
            },
          },
        ],
        [
          {
            name: 'show_pointer',
            config: {
              type: 'CheckboxControl',
              label: t('Show pointer'),
              description: t('Whether to show the pointer'),
              renderTrigger: true,
              default: true,
            },
          },
          {
            name: 'pointer_control_offset',
            config: {
              type: 'TextControl',
              label: t('pointer offset'),
              description: t('What should be pointer offset?'),
              renderTrigger: true,
              default: '10',
            },
          },
          {
            name: 'pointer_color',
            config: {
              type: 'TextControl',
              label: t('Pointer Color'),
              description: t('What should be pointer offset?'),
              renderTrigger: true,
              default: '10',
            },
          },
        ],
        [
          {
            name: 'content_font_size',
            config: {
              type: 'TextControl',
              label: t('Content size'),
              description: t('What should be content size?'),
              renderTrigger: true,
              default: '15',
            },
          },
          {
            name: 'label_control_offset',
            config: {
              type: 'TextControl',
              label: t('content offset'),
              description: t('What should be content offset?'),
              renderTrigger: true,
              default: '10',
            },
          },
          {
            name: 'content_color',
            config: {
              type: 'TextControl',
              label: t('Content Color'),
              description: t('What should be content color?'),
              renderTrigger: true,
              default: 'black',
            },
          },
        ],
        [
          {
            name: 'split_number',
            config: {
              type: 'SliderControl',
              label: t('Split number'),
              description: t('Number of split segments on the axis'),
              renderTrigger: true,
              min: 3,
              max: 30,
            },
          },
        ],
        [
          {
            name: 'margin_top',
            config: {
              type: 'TextControl',
              label: t('Top margin'),
              description: t('Top Margin to show chart on dashboard'),
              renderTrigger: true,
              default: '-100px',
            },
          },
        ],
        [
          {
            name: 'show_progress',
            config: {
              type: 'CheckboxControl',
              label: t('Show progress'),
              description: t('Whether to show the progress of gauge chart'),
              renderTrigger: true,
            },
          },
        ],
        [
          {
            name: 'round_cap',
            config: {
              type: 'CheckboxControl',
              label: t('Round cap'),
              description: t(
                'Style the ends of the progress bar with a round cap',
              ),
              renderTrigger: true,
              default: false,
            },
          },
        ],
        [
          {
            name: 'show_axis_tick',
            config: {
              type: 'CheckboxControl',
              label: t('Show axis line ticks'),
              description: t('Whether to show minor ticks on the axis'),
              renderTrigger: true,
              default: false,
            },
          },
        ],
        [
          {
            name: 'show_split_line',
            config: {
              type: 'CheckboxControl',
              label: t('Show split lines'),
              description: t('Whether to show the split lines on the axis'),
              renderTrigger: true,
            },
          },
        ],
      ],
    },
  ],
};
export default config;
