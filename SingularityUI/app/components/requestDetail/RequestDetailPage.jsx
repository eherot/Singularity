import React, { Component, PropTypes } from 'react';
import { connect } from 'react-redux';

import * as RefreshActions from '../../actions/ui/refresh';

import { FetchRequest } from '../../actions/api/requests';
import {
  FetchActiveTasksForRequest,
  FetchTaskHistoryForRequest
} from '../../actions/api/history';
import { FetchTaskCleanups } from '../../actions/api/tasks';

import RequestHeader from './RequestHeader';
import RequestActionExpirations from './RequestActionExpirations';
import ActiveTasksTable from './ActiveTasksTable';
import TaskHistoryTable from './TaskHistoryTable';
import RequestDeployHistory from './RequestDeployHistory';

class RequestDetailPage extends Component {
  componentDidMount() {
    this.props.refresh();
  }

  componentWillUnmount() {
    this.props.cancelRefresh();
  }

  render() {
    return (
      <div>
        <RequestHeader requestId={this.props.requestId} />
        <RequestActionExpirations requestId={this.props.requestId} />
        <ActiveTasksTable requestId={this.props.requestId} />
        <TaskHistoryTable requestId={this.props.requestId} />
        <RequestDeployHistory requestId={this.props.requestId} />
      </div>
    );
  }
}

RequestDetailPage.propTypes = {
  requestId: PropTypes.string.isRequired,
  refresh: PropTypes.func.isRequired,
  cancelRefresh: PropTypes.func.isRequired
};

const mapDispatchToProps = (dispatch, ownProps) => {
  const refreshActions = [
    FetchRequest.trigger(ownProps.requestId),
    FetchActiveTasksForRequest.trigger(ownProps.requestId),
    FetchTaskCleanups.trigger()
  ];
  return {
    refresh: () => dispatch(RefreshActions.BeginAutoRefresh(
      'RequestDetailPage',
      refreshActions,
      5000
    )),
    cancelRefresh: () => dispatch(
      RefreshActions.CancelAutoRefresh('RequestDetailPage')
    )
  };
};

export default connect(
  null,
  mapDispatchToProps
)(RequestDetailPage);