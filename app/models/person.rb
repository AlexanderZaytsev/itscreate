class Person < ActiveRecord::Base
  has_many :person_locations
  has_many :locations, through: :person_locations

  def picture
    { url: "http://graph.facebook.com/#{facebook_id}/picture?type=square", width: 50, height: 50 }
  end
  def self.sync_with_facebook
    token = 'CAACEdEose0cBAOSw064y4iPEllNsgFi4uxuN9gZB7h9nkdsti2K4GX146o9vIMlzmYQ2jRf96ZA904N4m5iR7KZBUFYB4DA53dGHbXDeVIQDz8Gh2fKcIrBYy57zZCb1DXXgHpnxTVgxe7qQPaij69uXmHOov0Go2G5jeLrGWjizpGavJ2SjxZCO5rkbxmEYZD'

    @graph = Koala::Facebook::API.new token

    ids = ["1319954442", "1199067665", "1467105130", "1533110096", "100001550831179", "643444407", "1577571400", "1143566428", "1047917325", "1317055422", "100006281170136", "500013837", "100000704371740", "567620839", "1499768337", "100001869141777", "532765789", "554192588", "1144506034", "1446321584", "760574549", "500061664", "100000560691583", "100006031839324", "611425260", "100000190847609", "100000158163689", "1008504783", "568448663", "1233761955", "645199470", "100003068674216", "849874569", "100000871574451", "826164312", "744186223", "744423428", "100000277496868", "1338570158", "563138593", "1517509633", "14203822", "1795158255", "682736734", "543714303", "660001114", "1440155610", "586124642", "1505088745", "512341960", "100000020390960", "1428848795", "633403687", "500043462", "1021186394", "1346695293", "1125674318", "1344466173", "100003741176793", "1383379567", "806230202", "1259042064", "1142281332", "746317943", "697981820", "100002145315047", "720245904", "1546701839", "1353995987", "1419920091", "1065709142", "718898202", "723442750", "1037612567", "1596943462", "100001141123467", "761185126", "694519474", "100001582951364", "529686614", "429618", "622074353", "524810424", "24102198", "592210849", "1035736317", "780859059", "1517657162"]

    for id in ids
      info = @graph.get_object(id)
      next unless info['location']

      person = Person.where(facebook_id: id).first_or_create(name: info['name'])

      location_info = @graph.get_object(info['location']['id'])['location']
      person.update(longitude: location_info['longitude'], latitude: location_info['latitude'])
    end
  end
end
