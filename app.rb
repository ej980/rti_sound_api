require 'sinatra'
require 'json'
require 'sinatra/cors'
require 'rack/cors'
require "base64"

use Rack::Cors do
  allow do
    origins 'https://meee.com.tw' 
    resource '/audio/*',
      headers: :any,
      methods: [:get, :options],
      credentials: true
  end
  allow do
    origins 'https://meee.com.tw' 
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :delete, :options, :head],
      credentials: true
  end
end

before '/audio/*' do
  response.headers['Access-Control-Allow-Origin'] = 'https://meee.com.tw'
end



options '*' do
  response.headers['Access-Control-Allow-Origin'] = 'https://meee.com.tw'
  response.headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, OPTIONS, HEAD'
  response.headers['Access-Control-Allow-Headers'] = 'Authorization, Content-Type'
  200
end



set :port, ENV['PORT'] || 4567  

get '/' do
  'API up!'
end

get '/' do
  content_type :json
  { message: 'Sound Menory API!' }.to_json
end

  months = [
    { id: 1, month_id: '1月 January', month: 'JAN', title: '臺灣藍鵲', mobile: 'https://meee.com.tw/xff0153.jpg', pc: 'https://meee.com.tw/p4h6BND.jpg', title_en: 'Taiwan Blue Magpie', img: 'https://meee.com.tw/HlI4HUH.jpg', copywriting: '位於圓山風景區的央廣圓山微波站是節目傳輸的起點，Rti的節目訊號由此傳送至各地分臺再向全球播送。漫步其中，常可見到臺灣特有鳥種臺灣藍鵲成群的身影，並聞其鳴叫聲。' , copyen: 'Located in the Yuanshan scenic area, Rti’s Yuanshan microwave transmission station is the starting point for transmitting programs. From here, Rti’s signal is sent to various substations and broadcast globally. As you walk around the area, you can often see flocks of Taiwan’s endemic bird, the Taiwan blue magpie, and hear their calls.' },
    { id: 2,month_id: '2月 February', month: 'FEB',title:'臺南鹽水烽炮', title_en:'Tainan Yanshui Beehive Fireworks Festival', img: 'https://meee.com.tw/y1y9eJx.jpg', copywriting: '已傳承逾130年的鹽水蜂炮源於祈求解除瘟疫，為一路燃放炮竹遶境的民俗活動。每年元宵節，臺南鹽水小鎮變身炮城，傍晚後蜂炮劃破夜空，讓民眾享受驚險震撼的炮火洗禮。', copyen: 'The Yanshui Beehive Fireworks Festival, a tradition spanning over 130 years, originated as a ritual to dispel plagues. This folk event features a procession with fireworks and firecrackers. Every year during the Lantern Festival, the small town Yanshui in Tainan transforms into a fortress of fireworks. As evening falls, the beehive fireworks light up the night sky, providing spectators with an exhilarating and breathtaking experience.' },
    { id: 3, month_id: '3月 March', month: 'MAR',title:'嘉義阿里山小火車', title_en:'Chiayi Alishan Forest Railway', img: 'https://i.meee.com.tw/bVfJrSL.jpg', copywriting: '阿里山鐵路建於1899年，每年阿里山的櫻花季，吸引遊客的不僅是櫻花還有小火車。每當國寶級的蒸汽火車頭SL-31鳴笛響起，獨特的櫻花鐵道之旅便隨之啟程。', copyen: 'Built in 1899, the Alishan Forest Railway attracts visitors not only for its cherry blossoms each year but also for its charming trains. When the iconic steam locomotive SL-31 blows its whistle, the unique cherry blossom railway journey begins, offering a memorable experience.'},
    { id: 4, month_id: '4月 April', month: 'APR',title:'臺中大甲媽祖遶境', title_en:'Taichung Dajia Mazu Pilgrimage', img: 'https://meee.com.tw/IPRxxNr.jpg', copywriting: '每年農曆3月，大甲鎮瀾宮舉行為期9天8夜的媽祖遶境，目的在祈求境內安康、安定人心。2021年Rti首次以11種語言直播大甲媽起駕盛況，向全球傳遞臺灣的信仰文化並祈求世界和平。', copyen: "Every year in the third month of the lunar calendar, the Dajia Jenn Lann Temple holds a nine-day Mazu Pilgrimage to pray for peace and stability. In 2021, Rti broadcast the grand event live in 11 languages for the first time, sharing Taiwan's cultural and religious heritage with the world and praying for global peace."},
    { id: 5,month_id: '5月 May', month: 'MAY',title:'淡水捷運', title_en:'Tamsui MRT Station', img: 'https://meee.com.tw/N935k8U.jpg', copywriting: '淡水站為臺北捷運淡水信義線的終點站，於1997年通車。站在月台上，觀音山景盡收眼底，且站點毗鄰淡水老街和古蹟廟宇，乘坐捷運即可探訪淡水的山海景色，盡享這新北市的旅遊觀光重鎮。', copyen: "Tamsui Station is the terminus of Taipei Metro's Tamsui-Xinyi Line, which began operations in 1997. From the platform, you can enjoy a panoramic view of Guanyin Mountain. The station is adjacent to Tamsui Old Street and historic temples, making it easy for one to explore the mountain and sea scenery of Tamsui and fully experience this tourist hub in New Taipei City."},
    { id: 6, month_id: '6月 June', month: 'JUN',title:'叭噗', title_en:'“Babu” Ice Cream Vendor', img: 'https://meee.com.tw/1LCtucB.jpg', copywriting: '每當叭噗聲響起，孩子們總會循聲找到古早味冰淇淋攤車的身影，「叭噗」因此成為臺灣傳統冰淇淋的代名詞，這聲音也成為臺灣人難忘的兒時回憶。', copyen: "Whenever the 'babu' sound is heard, children always follow the sound to find the old-fashioned ice cream cart. The 'babu' has become synonymous with traditional Taiwanese ice cream, and this sound has become a memorable part of many Taiwanese people's childhoods."},
    { id: 7, month_id: '7月 July', month: 'JUL',title:'臺北龍山寺', title_en:'Taipei Longshan Temple', img: 'https://meee.com.tw/crejJwT.jpg', copywriting: '落成於1738年的臺北龍山寺，主神像觀世音菩薩在二戰中殿堂全毀後仍安然無恙，使信徒敬拜更加虔誠，終年香火鼎盛、香客絡繹不絕。信眾常透過求籤和擲筊與神明溝通，尋求精神寄託。', copyen: 'Taipei Longshan Temple, completed in 1738, houses the main deity, Guanyin Bodhisattva, whose sculptures miraculously remained intact after the temple hall was destroyed during World War II. This event has led to even more devout worship by believers, with the temple bustling with visitors and incense burning year-round. Devotees often communicate with the divine spirits through fortune-telling sticks and casting moon blocks, seeking spiritual solace.'},
    { id: 8, month_id: '8月 August', month: 'AUG',title:'臺南菁寮天主堂', title_en:'Tainan Jingliao Saint Cross Catholic Church', img: 'https://meee.com.tw/hpqdTzM.jpg', copywriting: '在臺南後壁菁寮社區稻田間矗立著4座聖十字架天主堂，1957年為傳教開始興建，由德國建築師哥特佛萊德．波姆設計，其設計靈感來自稻米收成後的稻草堆。悠揚的鐘聲早已成為附近居民的生活點綴。', copyen: "In the Jingliao neighborhood of Tainan, amidst the rice paddies, stand the four towers of the Saint Cross Catholic Church. Construction began in 1957 to facilitate missionary work. The church was designed by German architect Gottfried Böhm and was inspired by stacks of rice straw after the harvest. The melodious ringing of the bells has long become a cherished part of the local residents' daily life."},
    { id: 9, month_id: '9月 September', month: 'SEP',title:'基隆中元祭放水燈', title_en:'Releasing Water Lanterns at Keelung Ghost Festival  ', img: 'https://meee.com.tw/WbBfbG7.jpg', copywriting: '為期一個月臺灣規模最大且歷史最久的基隆中元祭，每年都會在農曆7月14日午夜進行放水燈儀式，水燈替無後人奉祀的亡魂引路，引領祂們到陽間接受民眾的普渡供品。', copyen: 'The Keelung Ghost Festival, the largest and longest-running festival of its kind in Taiwan, spans a month. Every year, on the 14th day of the seventh lunar month at midnight, a water lantern ceremony is conducted. These lanterns guide the souls who have no descendants to honor them, leading them to the world of the living to receive offerings from the public.'},
    { id: 10, month_id: '10月 October', month: 'OCT',title:'新竹客家山歌', title_en:'Hsinchu Hakka Mountain Songs', img: 'https://meee.com.tw/0uVHhEM.jpg', copywriting: '客家山歌源於庶民生活，是客家先民在耕作、採茶或閒暇時即興創作的口傳歌謠，傳唱出生活中的喜怒哀樂，並深刻反映客家的文化意識、民族特性與民俗風情。', copyen: 'Hakka mountain songs originate from the lives of ordinary people and are oral folk songs improvised by Hakka ancestors during farming, tea picking, or leisure times. These songs express the joys, sorrows, and emotions of daily life and profoundly reflect Hakka cultural consciousness, ethnic characteristics, and folk customs.'},
    { id: 11, month_id: '11月 November', month: 'NOV',title:'泰雅族口簧琴', title_en:'The Atayal Tribe’s Mouth Harp', img: 'https://meee.com.tw/DEDzPaG.jpg', copywriting: '口簧琴是臺灣原住民泰雅族所使用的樂器。吹奏者透過口、手及簧片振動與口腔共鳴產生曲調與樂音，在泰雅族文化中扮演著傳遞訊息、特殊祭典樂舞的角色。', copyen: "The mouth harp is a musical instrument used by the Atayal, an Indigenous tribe in Taiwan. The player produces melodies and musical tones through the vibrations of the mouth, hands, and reed combined with the resonance of the oral cavity. In Atayal culture, it serves a role in conveying messages and performing music and dances at special ceremonies."},
    { id: 12, month_id: '12月 December', month: 'DEC',title:'燒肉粽', title_en:'"Sio Bah-tsàng" Sticky Rice Dumpling Vendor', img: 'https://meee.com.tw/SmrjCtN.jpg', copywriting: '在便利商店尚未普及的年代，賣肉粽的小販常在晚上九、十點後騎著車，以臺灣台語高喊「燒～肉粽」沿路叫賣(「燒」是熱的意思)。這熟悉的叫賣聲傳遞溫暖的臺灣滋味，是許多臺灣人共同的聲音記憶。', copyen: "Before there were convenience stores, vendors selling rice dumplings often rode their bikes late at night, around 9 or 10 p.m., calling out 'Sio Bah-tsàng' (‘Sio’ means hot in Tâi-gí) to hawk their goods. This familiar cry, a warm expression of Taiwanese flavor, is a shared auditory memory for many people in Taiwan."}
  ]
get '/months/list' do
  content_type :json
  months.to_json
end

set :public, 'public'

get '/audio/:file' do

  filename = params['filename']
  file_path = File.join('public', 'audio', "#{filename}.mp3")

  if File.exist?(file_path)
    base64_data = Base64.encode64(File.read(file_path))
    content_type :json
    { audio: base64_data }.to_json
  else
    status 404
    { error: 'File not found' }.to_json
  end

  end
