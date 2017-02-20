import React, { PropTypes } from 'react';

export default class UserArtist extends React.Component {
  constructor(props, _railsContext) {
    super(props);

    this.state = {active: props.active}
  }

  handleChange = (event) => {
    let active = $(event.target).is(':checked')
    let data   = {user_artist: {active: active}}
    $.ajax({
      url: this.props.activation_url,
      data: data,
      type: 'PUT',
      success: this.success
    })
  }

  success = (response) => {
    this.setState({active: response.active})
  }

  render() {
    return (
      <form>
        <label>
          {this.props.artist_name}
          <input type="checkbox" name="name" checked={this.state.active} onChange={this.handleChange}/>
        </label>
      </form>
    );
  }
}
