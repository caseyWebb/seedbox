# :tv: seedbox

Provisions a ready to go HTPC complete with:

  - Deluge, for torrents
  - NZBget, for usenet
  - CouchPotato, Sonarr, and Headphones for Movie, TV, and Music PVR
  - Plex

### Usage

You will need a domain. The setup script uses certbot (formerly letsencrypt)
to create SSL certs and it expects to be able to reach the domain configured
in `.env` on port ${HTTPS_PORT}.

Copy `.env.defaults` to `.env`, and change the values accordingly. They are
self-explanatory.

Then you're ready to run the setup script and start the seedbox with docker-compose

```bash
./setup.sh && docker-compose start && docker-compose logs -f
```
