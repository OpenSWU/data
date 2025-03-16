Sequel.migration do
  change do
    create_table :arenas do |t|
      string :id, fixed: true, size: 36, primary_key: true
      string :name
      string :locale, index: true
      string :description, text: true, default: ""

      index %i[name locale], unique: true
    end

    create_table :aspects do
      string :id, fixed: true, size: 36, primary_key: true
      string :name
      string :locale, index: true
      string :english_name
      string :color, fixed: true, size: 7
      string :description, text: true, default: ""

      index %i[name locale], unique: true
    end

    create_table :expansions do
      string :id, fixed: true, size: 36, primary_key: true
      string :name
      string :locale, index: true
      string :code, fixed: true, size: 3
      integer :card_count
      string :description, text: true, default: ""

      index %i[name code locale]
    end

    create_table :keywords do
      string :id, fixed: true, size: 36, primary_key: true
      string :name
      string :locale, index: true
      string :description, text: true, default: ""

      index %i[name locale], unique: true
    end

    create_table :rarities do
      string :id, fixed: true, size: 36, primary_key: true
      string :name
      string :english_name
      string :locale, index: true
      string :character, fixed: true, size: 1
      string :color, fixed: true, size: 7
      string :description, text: true, default: ""

      index %i[name english_name character locale]
    end

    create_table :traits do
      string :id, fixed: true, size: 36, primary_key: true
      string :name
      string :locale, index: true
      string :description, text: true, default: ""

      index %i[name locale], unique: true
    end

    create_table :types do
      string :id, fixed: true, size: 36, primary_key: true
      string :name
      string :locale, index: true
      string :value
      string :description, text: true, default: ""

      index %i[name locale], unique: true
    end

    create_table :cards do
      string :id, fixed: true, size: 36, primary_key: true
      string :swu_card_id
      string :locale, index: true
      string :title
      string :subtitle
      string :artist
      integer :card_number
      string :front_art_url
      string :back_art_url
      boolean :front_art_is_horizontal
      boolean :back_art_is_horizontal
      boolean :has_foil
      boolean :is_hyperspace
      boolean :is_showcase
      boolean :unique
      integer :play_cost
      integer :base_hp
      integer :base_power
      integer :upgrade_hp
      integer :upgrade_power
      foreign_key :expansion_id, :expansions, index: true, on_delete: :restrict, on_update: :restrict
      foreign_key :rarity_id, :rarities, index: true, on_delete: :restrict, on_update: :restrict
      foreign_key :front_type_id, :types, index: true, on_delete: :restrict, on_update: :restrict
      foreign_key :back_type_id, :types, null: true, index: true, on_delete: :restrict, on_update: :restrict

      index %i[title subtitle artist]
    end

    create_table :cards_arenas do
      foreign_key :arena_id, :arenas, type: "string(36)", on_delete: :restrict, on_update: :restrict
      foreign_key :card_id, :cards, type: "string(36)", on_delete: :restrict, on_update: :restrict
      index [:arena_id, :card_id]
    end

    create_table :cards_aspects do
      foreign_key :aspect_id, :aspects, type: "string(36)", on_delete: :restrict, on_update: :restrict
      foreign_key :card_id, :cards, type: "string(36)", on_delete: :restrict, on_update: :restrict
      index [:aspect_id, :card_id]
    end

    create_table :cards_keywords do
      foreign_key :keyword_id, :keywords, type: "string(36)", on_delete: :restrict, on_update: :restrict
      foreign_key :card_id, :cards, type: "string(36)", on_delete: :restrict, on_update: :restrict
      index [:card_id, :keyword_id]
    end

    create_table :cards_traits do
      foreign_key :trait_id, :traits, type: "string(36)", on_delete: :restrict, on_update: :restrict
      foreign_key :card_id, :cards, type: "string(36)", on_delete: :restrict, on_update: :restrict
      index [:card_id, :trait_id]
    end
  end
end
