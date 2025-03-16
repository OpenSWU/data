# OpenSWU Data

Scrapers, parsers, and exporters for OpenSWU card and expansion data. The
primary aim of this project is to provide card data, as published by Fantasy
Flight Games, for the Star Wars Unlimited card game.

## License

### Software

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program. If not, see <https://www.gnu.org/licenses/>.

### Databases (CSV, SQLite, etc.)

This project's database outputs; including CSV, SQLite, and others; are made
available under the Open Database License:
http://opendatacommons.org/licenses/odbl/1.0/. Any rights in individual
contents of the database are licensed under the Database Contents License:
http://opendatacommons.org/licenses/dbcl/1.0/

A full copy of the ODbL can also be found in [LICENSE.DATABASE.txt](LICENSE.DATABASE.txt).

## Using the Scraper

The `bin/scrape` command provides the main interface to the scraper. The
scraper works by building a local cache of JSON data for the parsers to then
traverse. It takes no arguments and will place the cache in
`tmp/cache/openswu-data` by default.

## Using the Exporters

> [!NOTE]
> The scraper builds the local cache used by the exporters, so be sure you run
> it first to populate your card list cache data. 

The exporters parse and export specific parts of the data in a consistent
format. CSV is the current default format and files will go to`tmp/exports`.

### `bin/export_cards`

Exports all identifying information for cards along with a v5 UUID defined for
each card to help with long-term identification. This exporter generates
`tmp/exports/cards.csv`

### `bin/export_expansions`

Exports expansion information for the cards in the cache along with a v5 UUID
for each expansion to help with long-term identification. This exporter
generates `tmp/exports/expansions.csv`
