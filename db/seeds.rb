# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

require('csv')

cards_csv_file = Rails.root.join('db/cards.csv')
cards_csv_data = File.read(cards_csv_file)
keywords_csv_file = Rails.root.join('db/keywords.csv')

sets_csv_file = Rails.root.join('db/sets.csv')
sets_csv_data = File.read(sets_csv_file)
keywords_csv_data = File.read(keywords_csv_file)

cards = CSV.parse(cards_csv_data, headers: true, encoding: "utf-8")
card_sets = CSV.parse(sets_csv_data, headers:true, encoding: "utf-8")
keywords = CSV.parse(keywords_csv_data, headers:true, encoding: "utf-8")

Card.destroy_all
MagicSet.destroy_all
Artist.destroy_all
Keyword.destroy_all

# Add Sets
card_sets.each do | card_set |
  new_set = MagicSet.create(
    code: card_set["code"],
    name: card_set["name"],
    block: card_set["block"],
    release_date: Date.strptime(card_set["release_date"],'%Y-%m-%d')
  );

  if !new_set.valid?
    puts "new_set error
            \n\tcode : #{card_set["code"]}
            \n\tname : #{card_set["name"]}
            \n\tblock : #{card_set["block"]}
            \n\trelease_date : #{card_set["release_date"]}";
    # 1993-12-01 Date Format
  end
end

# Add Keywords
keywords.each do | keyword |
  new_word = Keyword.create(
    keyword: keyword["Keyword"],
    effect: keyword["Effect"]
  )

  if !new_word.valid?
    puts "keyword error
            \n\tKeyword : #{keyword["Keyword"]}
            \n\tEffect : #{keyword["Effect"]}"
  end
end

# Add Cards
cards.each do | card |
  # Add / Find Artist
  artist = Artist.find_or_create_by(
    name: card["artist"]
  );

  if artist.valid?
    # Find the current card's set
    card_set = MagicSet.find_by code: card["setCode"]

    # Get all the keywords for this card
    keywords = card["keywords"].split(",")

    # Get Printings
    printings = card["printings"].split(",")

    # Get Original Printing
    original_printing_code = printings[0]
    original_printing = MagicSet.find_by code: original_printing_code

    # Validate original print set
    if original_printing.valid?
      begin
        new_card = artist.Card.create(
          ascii_name:           card["asciiName"]             ,
          border_color:         card["borderColor"]           ,
          color_identity:       card["colorIdentity"]         ,
          colors:               card["colors"]                ,
          cmc:                  card["convertedManaCost"]     ,
          finishes:             card["finishes"]              ,
          flavor_name:          card["flavorName"]            ,
          flavor_text:          card["flavorText"]            ,
          has_foil:             card["hasFoil"] == 1          ,
          is_alternative:       card["isAlternative"] == 1    ,
          is_fullart:           card["isFullArt"] == 1        ,
          is_oversized:         card["isOversized"] == 1      ,
          is_promo:             card["isPromo"] == 1          ,
          is_reprint:           card["isReprint"] == 1        ,
          is_reserved:          card["isReserved"] == 1       ,
          layout:               card["layout"]                ,
          life:                 card["life"]                  ,
          loyalty:              card["loyalty"]               ,
          mana_cost:            card["manaCost"]              ,
          name:                 card["name"]                  ,
          original_printing_id: original_printing.id          ,
          power:                card["power"]                 ,
          toughness:            card["toughness"]             ,
          rarity:               card["rarity"]                ,
          scryfallid:           card["scryfallId"]            ,
          card_set_id:          card_set.id                   ,
          card_text:            card["text"]                  )
      rescue => error
        puts "card error
                \n\tartist_id:            #{artist.id}
                \n\tascii_name:           #{card["asciiName"]}
                \n\tborder_color:         #{card["borderColor"]}
                \n\tcolor_identity:       #{card["colorIdentity"]}
                \n\tcolors:               #{card["colors"]}
                \n\tcmc:                  #{card["convertedManaCost"]}
                \n\tfinishes:             #{card["finishes"]}
                \n\tflavour_name:         #{card["flavorName"]}
                \n\tflavour_text:         #{card["flavorText"]}
                \n\thas_foil:             #{card["hasFoil"] == 1}
                \n\tis_alternative:       #{card["isAlternative"] == 1}
                \n\tis_fullart:           #{card["isFullArt"] == 1}
                \n\tis_oversized:         #{card["isOversized"] == 1}
                \n\tis_promo:             #{card["isPromo"] == 1}
                \n\tis_reprint:           #{card["isReprint"] == 1}
                \n\tis_reserved:          #{card["isReserved"] == 1}
                \n\tlayout:               #{card["layout"]}
                \n\tlife:                 #{card["life"]}
                \n\tloyalty:              #{card["loyalty"]}
                \n\tmana_cost:            #{card["manaCost"]}
                \n\tname:                 #{card["name"]}
                \n\toriginal_printing_id: #{original_printing.id}
                \n\tpower:                #{card["power"]}
                \n\ttoughness:            #{card["toughness"]}
                \n\trarity:               #{card["rarity"]}
                \n\tscryfallid:           #{card["scryfallId"]}
                \n\tcard_set_id:          #{card_set.id}
                \n\tcard_text:            #{card["text"]}"

        puts "\n\n" error.message
        exit!
      end


      if new_card.valid?
        # Parse Card Supertypes
        supertype_data = card["supertypes"].split(",")

        # Add Card Supertypes
        supertype_data.each do | supertype |
          begin
            new_card.supertypes.find_or_create_by(
              name: supertype
            )
          rescue
            puts "card_supertype error
                    \n\t card_id : #{new_card.id}
                    \n\t supertype_id : #{type.id}
                    \n\t supertype : #{supertype}"
          end
        end

        # Parse Card Subtypes
        subtype_data = card["subtypes"].split(",")

        # Add Card Subtypes
        subtype_data.each do | subtype |
          begin
            new_card.subtypes.find_or_create_by(
              name: subtype
            )
          rescue
            puts "card_subtype error
                    \n\t card_id : #{new_card.id}
                    \n\t subtype_id : #{type.id}
                    \n\t subtype : #{subtype}"
          end
        end

        # Add Card Printings
        printings.each do | printing_code |
          begin
            new_card.magicsets.find_or_create_by(
              code: printing_code
            )

          rescue
            puts "printing error\
                    \n\tprinting_code : #{printing_code}"
          end
        end
      else
        # Invalid Card
        puts "card error
                \n\tartist_id:            #{artist.id}
                \n\tascii_name:           #{card["asciiName"]}
                \n\tborder_color:         #{card["borderColor"]}
                \n\tcolor_identity:       #{card["colorIdentity"]}
                \n\tcolors:               #{card["colors"]}
                \n\tcmc:                  #{card["convertedManaCost"]}
                \n\tfinishes:             #{card["finishes"]}
                \n\tflavour_name:         #{card["flavorName"]}
                \n\tflavour_text:         #{card["flavorText"]}
                \n\thas_foil:             #{card["hasFoil"] == 1}
                \n\tis_alternative:       #{card["isAlternative"] == 1}
                \n\tis_fullart:           #{card["isFullArt"] == 1}
                \n\tis_oversized:         #{card["isOversized"] == 1}
                \n\tis_promo:             #{card["isPromo"] == 1}
                \n\tis_reprint:           #{card["isReprint"] == 1}
                \n\tis_reserved:          #{card["isReserved"] == 1}
                \n\tlayout:               #{card["layout"]}
                \n\tlife:                 #{card["life"]}
                \n\tloyalty:              #{card["loyalty"]}
                \n\tmana_cost:            #{card["manaCost"]}
                \n\tname:                 #{card["name"]}
                \n\toriginal_printing_id: #{original_printing.id}
                \n\tpower:                #{card["power"]}
                \n\ttoughness:            #{card["toughness"]}
                \n\trarity:               #{card["rarity"]}
                \n\tscryfallid:           #{card["scryfallid"]}
                \n\tcard_set_id:          #{card_set.id}
                \n\tcard_text:            #{card["text"]}"
      end
    # Invalid Original Set
    else
      puts "original print set error
              \n\tcode : #{card["originalPrintings"]}"
    end
  # Invalid Artist
  else
    puts "artist error
                \n\tname : #{card["artist"]}"
  end
end