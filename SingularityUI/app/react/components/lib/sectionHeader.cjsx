SectionHeader = React.createClass
  
  displayName: 'SectionHeader'

  render: ->
    <div className="page-header">
      <h2>{this.props.title}</h2>
    </div>

module.exports = SectionHeader