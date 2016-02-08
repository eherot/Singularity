Utils = require '../../utils'
Enums = require './Enums'
TaskSearchForm = require './TaskSearchForm'
TaskSearchSubmitted = require './TaskSearchSubmitted'

TaskSearch = React.createClass

    headerText: 'Search for Tasks'

    getInitialState: ->
        return {
            requestId: @props.initialRequestId
            deployId: @props.initialDeployId
            host: @props.initialHost
            lastTaskStatus: @props.initialTaskStatus
            startedBefore: @props.initialStartedBefore
            startedAfter: @props.initialStartedAfter
            sortDirection: @props.initialSortDirection
            showForm: true
        }

    handleSubmit: (event) ->
        event.preventDefault()
        @setState({
            showForm: false
        })

    # Annoying that we need a new function for each property.
    # Unfortuantely using a curried function doesn't seem to work.
    updateReqeustId: (event) ->
        @setState({
            requestId: event.target.value
        })

    updateDeployId: (event) ->
        @setState({
            deployId: event.target.value
        })

    updateHost: (event) ->
        @setState({
            host: event.target.value
        })

    updateLastTaskStatus: (event) ->
        @setState({
            lastTaskStatus: event.target.value
        })

    updateStartedBefore: (event) ->
        @setState({
            startedBefore: event.date
        })

    updateStartedAfter: (event) ->
        @setState({
            startedAfter: event.date
        })

    updateSortDirection: (event) ->
        @setState({
            sortDirection: event.target.value
        })

    updatePageNumber: (event) ->
        @setState({
            pageNumber: event.target.value
        })

    render: ->
        if @state.showForm
            return <TaskSearchForm
                headerText = @headerText
                handleSubmit = @handleSubmit
                requestId = @state.requestId
                requestLocked = @props.requestLocked
                updateReqeustId = @updateReqeustId
                deployId = @state.deployId
                updateDeployId = @updateDeployId
                host = @state.host
                updateHost = @updateHost
                lastTaskStatus = @state.lastTaskStatus
                updateLastTaskStatus = @updateLastTaskStatus
                startedBefore = @state.startedBefore
                updateStartedBefore = @updateStartedBefore
                startedAfter = @state.startedAfter
                updateStartedAfter = @updateStartedAfter
                sortDirection = @state.sortDirection
                updateSortDirection = @updateSortDirection
            />
        else
            return <TaskSearchSubmitted
                requestId = @state.requestId
                requestLocked = @state.requestLocked
                deployId = @state.deployId
                host = @state.host
                lastTaskStatus = @state.lastTaskStatus
                startedBefore = @state.startedBefore
                startedAfter = @state.startedAfter
                sortDirection = @state.sortDirection
                page = 1
                count = 10
            />


module.exports = TaskSearch