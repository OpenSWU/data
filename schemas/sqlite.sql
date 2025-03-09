create table arenas
(
    id          string          not null
        constraint arenas_pk
            primary key,
    name        string          not null,
    locale      string          not null,
    description text default '' not null
);

create unique index arenas_name_locale_index
    on arenas (name desc, locale desc);

create table aspects
(
    id           string          not null
        constraint aspects_pk
            primary key,
    name         string          not null,
    locale       string          not null,
    english_name string          not null,
    color        string          not null,
    description  text default '' not null
);

create unique index aspects_name_locale_index
    on aspects (name desc, locale desc);

create table expansions
(
    id          string             not null
        constraint expansions_pk
            primary key,
    name        string             not null,
    locale      string             not null,
    code        string             not null,
    card_count  integer default 0  not null,
    description text    default '' not null
);

create index expansions_code_index
    on expansions (code desc);

create index expansions_name_locale_index
    on expansions (name desc, locale desc);

create table keywords
(
    id          string          not null
        constraint keywords_pk
            primary key,
    name        string          not null,
    locale      string          not null,
    description text default '' not null
);

create unique index keywords_name_locale_index
    on keywords (name desc, locale desc);

create table rarities
(
    id           string          not null
        constraint rarities_pk
            primary key,
    name         string          not null,
    locale       string          not null,
    character    string          not null,
    color        string          not null,
    english_name string          not null,
    description  text default '' not null
);

create unique index rarities_name_locale_index
    on rarities (name desc, locale desc);

create table sqlite_master
(
    type     TEXT,
    name     TEXT,
    tbl_name TEXT,
    rootpage INT,
    sql      TEXT
);

create table traits
(
    id          string          not null
        constraint traits_pk
            primary key,
    name        string          not null,
    locale      string          not null,
    description text default '' not null
);

create unique index traits_name_locale_index
    on traits (name desc, locale desc);

create table types
(
    id          string          not null
        constraint types_pk
            primary key,
    name        string          not null,
    locale      string          not null,
    value       string          not null,
    description text default '' not null
);

create table cards
(
    id                      string  not null
        constraint cards_pk
            primary key,
    swu_card_id             string  not null,
    locale                  string  not null,
    title                   string  not null,
    subtitle                string,
    card_number             integer not null,
    artist                  string  not null,
    front_art_url           string  not null,
    back_art_url            string,
    front_art_is_horizontal bool    not null,
    back_art_is_horizontal  bool    not null,
    has_foil                bool    not null,
    is_hyperspace           bool    not null,
    is_showcase             bool    not null,
    "unique"                bool    not null,
    play_cost               integer,
    base_hp                 integer,
    base_power              integer,
    upgrade_hp              integer,
    upgrade_power           integer,
    expansion_id            string  not null
        constraint cards_expansions_id_fk
            references expansions,
    rarity_id               string  not null
        constraint cards_rarities_id_fk
            references rarities,
    front_type_id           string  not null
        constraint cards_front_types_id_fk
            references types,
    back_type_id            string
        constraint cards_back_types_id_fk
            references types
);

create index cards_expansion_id_rarity_id_index
    on cards (expansion_id, rarity_id);

create index cards_locale_index
    on cards (locale desc);

create index types_name_locale_index
    on types (name desc, locale desc);


