# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# CARD
  # index	id
  # artist
  # asciiName
  # borderColor
  # colorIdentity
  # colors
  # convertedManaCost
  # finishes
  # flavorName
  # flavorText
  # hasFoil
  # hasNonFoil
  # isAlternative
  # isFullArt
  # isOversized
  # isPromo
  # isReprint
  # isReserved
  # keywords
  # layout
  # life
  # loyalty
  # manaCost
  # name
  # originalPrintings
  # power
  # printings
  # set
  # scryfallId
  # scryfallIllustrationId
  # setCode
  # subtypes
  # supertypes
  # text
  # toughness
  # types

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
# MagicSet.destroy_all
# Artist.destroy_all
# Keyword.destroy_all

# Add all sets
# card_sets.each do | card_set |
#   new_set = MagicSet.create(
#     code: card_set["code"],
#     name: card_set["name"],
#     block: card_set["block"],
#     release_date: card_set["release_date"]
#   );

#   if !new_set.valid?
#     puts "new_set error
#             \n\tcode : #{card_set["code"]}
#             \n\tname : #{card_set["name"]}
#             \n\tblock : #{card_set["block"]}
#             \n\trelease_date : #{card_set["release_date"]}";
#   end
# end

#Add all keywords
# keywords.each do | keyword |
#   new_word = Keyword.create(
#     keyword: keyword["Keyword"],
#     effect: keyword["Effect"]
#   )

#   if !new_word.valid?
#     puts "keyword error
#             \n\tKeyword : #{keyword["Keyword"]}
#             \n\tEffect : #{keyword["Effect"]}"
#   end
# end



cards.each do | card |
  # Find or create the artist entry
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
    original_printing_code = printings[0]
    original_printing = MagicSet.find_by code: original_printing_code

    # Validate original print set
    if original_printing.valid?
      begin
        new_card = Card.create(
          artist_id:            artist.id                     ,
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
        supertype_data.each do | supertype |
          type = Supertype.find_or_create_by(
            name: supertype
          )

          #Card-Supertype table update
          if type.valid?
            new_card_supertype = CardSupertype.create(
              card_id: new_card.id,
              supertype_id: type.id
            )

            puts "card_supertype error
                    \n\t card_id : #{new_card.id}
                    \n\t supertype_id : #{type.id}" if !new_card_supertype.valid?
          end
        end

        # Parse Card Subtypes
        subtype_data = card["subtypes"].split(",")
        subtype_data.each do | subtype |
          type = Subtype.find_or_create_by(
            name: subtype
          )

          #Card-Subtype table update
          if type.valid?
            new_card_subtype = CardSubtype.create(
              card_id: new_card.id,
              subtype_id: type.id
            )

            puts "card_subtype error
                    \n\t card_id : #{new_card.id}
                    \n\t subtype_id : #{type.id}" if !new_card_subtype.valid?
          end
        end

        printings.each do | printing_code |
          printing = MagicSet.find_by code: printing_code

          if printing.valid?
            card_printings.create(
              cards_id: new_card.id,
              magicsets_id: printing.id
            )
          else
            puts "printing error\
                    \n\tprinting_code : #{printing_code}"
          end
        end

      # Invalid Card
      else
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