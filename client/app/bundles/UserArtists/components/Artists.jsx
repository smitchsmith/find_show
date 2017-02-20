import React, { PropTypes } from 'react';
import UserArtist from './UserArtist';

export default class Artists extends React.Component {
  constructor(props, _railsContext) {
    super(props);
  }

  render() {
    return (
      <div>
        {this.props.userArtists.map(
          userArtist => <UserArtist {...userArtist} key={userArtist.id} />
        )}
      </div>
    );
  }
}
