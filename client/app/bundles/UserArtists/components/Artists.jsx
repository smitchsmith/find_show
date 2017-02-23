import React, { PropTypes } from 'react';
import UserArtist from './UserArtist';

export default class Artists extends React.Component {
  constructor(props, _railsContext) {
    super(props);

    this.state = {userArtists: props.userArtists}
  }

  render() {
    return (
      <div className="artists-component grid -center">
        <div className="cell -6of12">
          {this.state.userArtists.map(
            userArtist => <UserArtist {...userArtist} key={userArtist.id} />
          )}
        </div>
      </div>
    );
  }
}
