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
import { t, GenericDataType } from '@superset-ui/core';
import {
  ControlPanelConfig,
  sections,
  D3_FORMAT_DOCS,
  D3_TIME_FORMAT_OPTIONS,
} from '@superset-ui/chart-controls';
import { D3_FORMAT_OPTIONS } from '../utils';

export default {
  controlPanelSections: [
    sections.legacyTimeseriesTime,
    {
      label: t('Query'),
      expanded: true,
      controlSetRows: [['metric'], ['adhoc_filters']],
    },
    {
      label: t('Options'),
      expanded: true,
      tabOverride: 'data',
      controlSetRows: [
        [
          {
            name: 'subheader',
            config: {
              type: 'TextControl',
              label: t('Subheader'),
              renderTrigger: true,
              description: t(
                'Description text that shows up below your Big Number',
              ),
            },
          },
        ],
        // TODO SWIGGY: UPDATION
        [
          {
            name: 'y_axis_format',
            config: {
              type: 'SelectControl',
              label: t('Number format'),
              renderTrigger: true,
              choices: D3_FORMAT_OPTIONS,
              default: 'SMART_NUMBER',
              description: D3_FORMAT_DOCS,
            },
          },
        ],
        // TODO SWIGGY: UPDATION END
        [
          {
            name: 'force_timestamp_formatting',
            config: {
              type: 'CheckboxControl',
              label: t('Timestamp Format'),
              renderTrigger: true,
              default: false,
              description: t('Whether to format the timestamp'),
            },
          },
        ],
        [
          {
            name: 'time_format',
            config: {
              type: 'SelectControl',
              freeForm: true,
              label: t('Date format'),
              renderTrigger: true,
              choices: D3_TIME_FORMAT_OPTIONS,
              description: D3_FORMAT_DOCS,
              default: '%d-%m-%Y %H:%M:%S',
              visibility(props) {
                const { force_timestamp_formatting } = props.form_data;
                return !!force_timestamp_formatting;
              },
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
            name: 'header_font_size',
            config: {
              type: 'SelectControl',
              label: t('Big Number Font Size'),
              renderTrigger: true,
              clearable: false,
              default: 0.4,
              // Values represent the percentage of space a header should take
              options: [
                {
                  label: t('Tiny'),
                  value: 0.2,
                },
                {
                  label: t('Small'),
                  value: 0.3,
                },
                {
                  label: t('Normal'),
                  value: 0.4,
                },
                {
                  label: t('Large'),
                  value: 0.5,
                },
                {
                  label: t('Huge'),
                  value: 0.6,
                },
                {
                  label: t('Extra Huge'),
                  value: 0.7,
                },
              ],
            },
          },
        ],
        [
          {
            name: 'subheader_font_size',
            config: {
              type: 'SelectControl',
              label: t('Subheader Font Size'),
              renderTrigger: true,
              clearable: false,
              default: 0.15,
              // Values represent the percentage of space a subheader should take
              options: [
                {
                  label: t('Tiny'),
                  value: 0.125,
                },
                {
                  label: t('Small'),
                  value: 0.15,
                },
                {
                  label: t('Normal'),
                  value: 0.2,
                },
                {
                  label: t('Large'),
                  value: 0.3,
                },
                {
                  label: t('Huge'),
                  value: 0.4,
                },
                {
                  label: t('Extra Huge'),
                  value: 0.5,
                },
              ],
            },
          },
        ],
        // TODO SWIGGY: ADDITION
        [
          {
            name: 'conditional_formatting',
            config: {
              type: 'ConditionalFormattingControl',
              renderTrigger: true,
              label: t('Conditional Formatting'),
              description: t('Apply conditional color formatting to metric'),
              shouldMapStateToProps() {
                return true;
              },
              mapStateToProps(explore, _, chart) {
                const verboseMap = explore?.datasource?.hasOwnProperty(
                  'verbose_map',
                )
                  ? explore?.datasource?.columns
                  : explore?.datasource?.columns ?? {};
                const { colnames, coltypes } =
                  chart?.queriesResponse?.[0] ?? {};
                const numericColumns =
                  Array.isArray(colnames) && Array.isArray(coltypes)
                    ? colnames
                        .filter(
                          (colname: string, index: number) =>
                            coltypes[index] === GenericDataType.NUMERIC,
                        )
                        .map(colname => ({
                          value: colname,
                          label: verboseMap[colname] ?? colname,
                        }))
                    : [];
                return {
                  columnOptions: numericColumns,
                  verboseMap,
                };
              },
            },
          },
        ],
        // TODO SWIGGY: ADDITION END
      ],
    },
  ],
} as ControlPanelConfig;
