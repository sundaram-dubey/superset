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
import { t } from '@superset-ui/core';
import {
  ControlPanelConfig,
  sections,
  sharedControls,
} from '@superset-ui/chart-controls';

export default {
  controlPanelSections: [
    sections.legacyTimeseriesTime,
    {
      label: t('Query'),
      expanded: true,
      controlSetRows: [
        // UPDATION
        [{ name: 'metrics', config: sharedControls.metrics }],
        // UPDATION-END
        ['adhoc_filters'],
      ],
    },
    {
      label: t('Options'),
      expanded: true,
      tabOverride: 'data',
      controlSetRows: [
        // UPDATION
        [
          {
            name: 'cols_per_row',
            config: {
              type: 'SelectControl',
              label: 'Metrics Per Row',
              renderTrigger: true,
              description: 'Number of metrics to show in a row',
              choices: [[1], [2], [3], [4], [6]],
              default: 3,
            },
          },
        ],
        // UPDATION-END
        // ADDITION
        [
          {
            name: 'font_family',
            config: {
              type: 'SelectControl',
              label: 'Font Style',
              renderTrigger: true,
              default: 'Inter',
              choices: [
                ['Inter'],
                ['Helvetica'],
                ['Georgia'],
                ['Times New Roman'],
                ['Fira Code'],
                ['monospace'],
              ],
              description: 'Font style used for text',
            },
          },
        ],
        [
          {
            name: 'heading_size',
            config: {
              type: 'TextControl',
              label: 'Metric name fontsize',
              renderTrigger: true,
              isInt: true,
              default: 24,
              description: 'Font Size for the metric name',
            },
          },
        ],
        [
          {
            name: 'bignumber_size',
            config: {
              type: 'TextControl',
              label: 'Bignumber fontsize',
              renderTrigger: true,
              isInt: true,
              default: 20,
              description: 'Font Size for the bignumber',
            },
          },
        ],
        // ADDITION-END
      ],
    },
    // {
    //   label: t('Chart Options'),
    //   expanded: true,
    //   controlSetRows: [
    // [headerFontSize],
    // [subheaderFontSize],
    // ['y_axis_format'],
    // [
    //   {
    //     name: 'time_format',
    //     config: {
    //       type: 'SelectControl',
    //       freeForm: true,
    //       label: t('Date format'),
    //       renderTrigger: true,
    //       choices: D3_TIME_FORMAT_OPTIONS,
    //       description: D3_FORMAT_DOCS,
    //       default: smartDateFormatter.id,
    //     },
    //   },
    // ],
    // [
    //   {
    //     name: 'force_timestamp_formatting',
    //     config: {
    //       type: 'CheckboxControl',
    //       label: t('Force date format'),
    //       renderTrigger: true,
    //       default: false,
    //       description: t(
    //         'Use date formatting even when metric value is not a timestamp',
    //       ),
    //     },
    //   },
    // ],
    //     ],
    //   },
  ],
  // controlOverrides: {
  //   y_axis_format: {
  //     label: t('Number format'),
  //   },
  // },
} as ControlPanelConfig;
