import React from 'react';
import PropTypes from 'prop-types';
import ComponentFactory from './ComponentFactory';
import { getNestedValue } from '../utils/get-nested-value';

// For now, explicitly define the arguments that should be accepted for Gatsby to build the node
const VALID_COND_ARGS = ['html', '(not man)', 'cloud'];

const Cond = ({ nodeData, ...rest }) => {
  const argument = getNestedValue(['argument', 0, 'value'], nodeData);
  if (VALID_COND_ARGS.includes(argument)) {
    return nodeData.children.map((child, index) => <ComponentFactory {...rest} nodeData={child} key={index} />);
  }
  return null;
};

Cond.propTypes = {
  nodeData: PropTypes.shape({
    argument: PropTypes.arrayOf(
      PropTypes.shape({
        value: PropTypes.string,
      }).isRequired
    ).isRequired,
  }).isRequired,
};

export default Cond;
