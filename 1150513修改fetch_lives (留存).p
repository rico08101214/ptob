#!/usr/bin/python3
# -*- coding: utf-8 -*-

import yt_dlp
import re
import os
import time

# ==========================================
# 1. 頻道與手動連結配置區
# ==========================================
CATEGORIES = {

	
	"⚠️新聞頻道⚠️,#genre#": {
        "東森新聞": "https://www.youtube.com/@newsebc/",
		"TVBS NEWS": "https://www.youtube.com/@TVBSNEWS01/",
		"中天新聞CtiNews": "https://www.youtube.com/@中天新聞CtiNews/",
        "中天電視CtiTv": "https://www.youtube.com/@中天電視CtiTv/",
		"台灣地震監視": "https://www.youtube.com/@台灣地震監視/",
        "台灣颱風論壇": "https://www.youtube.com/@twtybbs2009/",		
        "台視新聞": "https://www.youtube.com/@TTV_NEWS/",
        "中視新聞": "https://www.youtube.com/@chinatvnews/",
        "中視新聞 HD": "https://www.youtube.com/@twctvnews/",
        "華視新聞": "https://www.youtube.com/@CtsTw/",
        "民視新聞網": "https://www.youtube.com/@FTV_News/",
        "公視": "https://www.youtube.com/@ptslivestream/",
        "公視新聞網": "https://www.youtube.com/@PNNPTS/",
        "公視台語台": "https://www.youtube.com/@ptstaigitai/",
        "TaiwanPlus": "https://www.youtube.com/@TaiwanPlusLive/",		
        "大愛電視": "https://www.youtube.com/@DaAiVideo/",
        "鏡新聞": "https://www.youtube.com/@mnews-tw/",
        "三立iNEWS": "https://www.youtube.com/channel/UCoNYj9OFHZn3ACmmeRCPwbA",		
        "三立LIVE新聞": "https://www.youtube.com/@setnews/",
        "中天亞洲台": "https://www.youtube.com/@中天亞洲台CtiAsia/",	
        "Focus全球新聞": "https://www.youtube.com/@tvbsfocus/",	
        "寰宇新聞": "https://www.youtube.com/@globalnewstw/",
        "寰宇全視界": "https://www.youtube.com/@globalvisiontalk/",		
        "udn video": "https://www.youtube.com/@udn-video/",
        "CNEWS匯流新聞網": "https://www.youtube.com/@CNEWS/",	
        "新唐人亞太電視台": "https://www.youtube.com/@NTDAPTV/",
        "八大民生新聞": "https://www.youtube.com/@gtvnews27/",		
        "原視新聞網 TITV News": "https://www.youtube.com/@TITVNews16/",
        "飛碟聯播網": "https://www.youtube.com/@921ufonetwork/",		
        "三大一台": "https://www.youtube.com/@SDTV55ch/",	
        "中天財經頻道": "https://www.youtube.com/@中天財經頻道CtiFinance/",	
        "東森財經股市": "https://www.youtube.com/@57ETFN/",	
        "寰宇財經新聞": "https://www.youtube.com/@globalmoneytv/",
        "非凡電視": "https://www.youtube.com/@ustv/",
        "非凡商業台": "https://www.youtube.com/@ustvbiz/",	
        "運通財經台": "https://www.youtube.com/@EFTV01/",
        "全球財經台2": "https://www.youtube.com/@全球財經台2/",	
        "AI主播倪珍Nikki 播新聞": "https://www.youtube.com/@NOWNEWS-AI-Anchor-Niki/",
        "BNE TV - 新西兰中文国际频道": "https://www.youtube.com/@BNETVNZ/",	
        "POP Radio聯播網": "https://www.youtube.com/@917POPRadio/",
        "LIVE NOW": "https://www.youtube.com/@LiveNow24H/",	
        "鳳凰衛視PhoenixTV": "https://www.youtube.com/@phoenixtvglobal/",
        "HOY 資訊台 × 有線新聞": "https://www.youtube.com/@HOYTVHK/",		
        "CCTV中文": "https://www.youtube.com/@CCTVCH/featured",
        "8world": "https://www.youtube.com/@8worldSG/"
    },
    "☣️綜藝頻道☣️,#genre#": {
        "57怪奇物語": "https://www.youtube.com/@57StrangerThings/",
		"華視綜藝頻道": "https://www.youtube.com/@CTSSHOW/",
        "綜藝大熱門": "https://www.youtube.com/@HotDoorNight/",
		"綜藝玩很大": "https://www.youtube.com/@Mr.Player/",
		"台視時光機": "https://www.youtube.com/@TTVClassic/",
		"國光幫幫忙": "https://www.youtube.com/@KuoKuanForever/",
		"MIT台灣誌": "https://www.youtube.com/@ctvmit/",
        "大陸尋奇": "https://www.youtube.com/@ctvchinatv/",	
        "八大電視娛樂百分百": "https://www.youtube.com/@GTV100ENTERTAINMENT/",
        "三立娛樂星聞": "https://www.youtube.com/@star_setn/",	
        "中視經典綜藝": "https://www.youtube.com/@ctvent_classic/",
        "綜藝一級棒": "https://www.youtube.com/@NO1TVSHOW/",
        "小姐不熙娣": "https://www.youtube.com/@deegirlstalk/",
        "民視 超級冰冰Show": "https://www.youtube.com/@superbingbingshow/",
        "民視綜藝娛樂 Formosa TV Entertainments": "https://www.youtube.com/@FTV_Show/",
        "民視生活資訊 Formosa TV Life": "https://www.youtube.com/@FTVLifeInfo/",			
        "木曜4超玩": "https://www.youtube.com/@Muyao4/",	
        "一字千金": "https://www.youtube.com/@ptsword/",			
        "11點熱吵店": "https://www.youtube.com/@chopchopshow/",
        "飢餓遊戲": "https://www.youtube.com/@HungerGames123/",	
        "豬哥會社": "https://www.youtube.com/@FTV_ZhuGeClub/",
        "百變智多星": "https://www.youtube.com/@百變智多星/",
        "公視+": "https://www.youtube.com/@PTSplus/",
        "公視戲劇 PTS Drama": "https://www.youtube.com/@ptsdrama/",		
        "東森綜合台": "https://www.youtube.com/@ettv32/",
        "中天娛樂頻道": "https://www.youtube.com/user/ctimulti",		
        "命運好好玩": "https://www.youtube.com/@eravideo004/",	
        "TVBS娛樂頭條": "https://www.youtube.com/@tvbsenews/",	
        "台灣啟示錄": "https://www.youtube.com/@ebcapocalypse/",
        "緯來日本台": "https://www.youtube.com/@VideolandJapan/",
        "我愛小明星大跟班": "https://www.youtube.com/@我愛小明星大跟班/",
        "明星下班路": "https://www.youtube.com/@gtvstaroad/videos",		
        "204檔案": "https://www.youtube.com/@204/",
        "台灣大搜索": "https://www.youtube.com/@台灣大搜索CtiCSI/",		
        "WTO姐妹會": "https://www.youtube.com/@WTOSS/",
        "為民也有約": "https://www.youtube.com/@%E7%82%BA%E6%B0%91%E4%B9%9F%E6%9C%89%E7%B4%84/",		
        "好看娛樂": "https://www.youtube.com/@好看娛樂/",
        "關鍵時刻": "https://www.youtube.com/@ebcCTime/",		
        "超級夜總會": "https://www.youtube.com/@SuperNightClubCH29/videos",	
        "TVBS女人我最大": "https://www.youtube.com/@tvbsqueen/",
        "型男大主廚": "https://www.youtube.com/@twcookingshow/videos",
        "娛樂星動線": "https://www.youtube.com/@chinatimesent/",		
        "非凡大探索": "https://www.youtube.com/@ustvfoody/",
        "你好星期六 Hello Saturday Official": "https://youtube.com/@hellosaturdayofficial?si=--6KGPLtLMpXRMN5",	
        "BIF相信未來 官方頻道": "https://www.youtube.com/@BelieveinfutureTV/",
        "GTV 自由的旅行者": "https://www.youtube.com/@gtvfreedomtravelers/",
        "原視 TITV+": "https://www.youtube.com/@titv8932/videos",
		"寶島神很大": "https://www.youtube.com/@godBlessBaodao/",
        "Taste The World": "https://www.youtube.com/@TasteTheWorld66/videos",
        "現在宅知道": "https://www.youtube.com/@cbotaku/",
		"娱综星天地": "https://www.youtube.com/@娱综星天地/",
        "靖天電視台": "https://www.youtube.com/@goldentvdrama/",
        "靈異錯別字": "https://www.youtube.com/@靈異錯別字ctiwugei/",
        "綜藝一級棒": "https://www.youtube.com/@NO1TVSHOW/",		
        "下面一位": "https://www.youtube.com/@ytnextone_1/",		
        "公共電視-我們的島": "https://www.youtube.com/@ourislandTAIWAN/",
        "WeTV 綜藝經典": "https://www.youtube.com/@WeTV-ClassicVariety/videos",
        "爆梗TV": "https://www.youtube.com/@爆梗PunchlineTV/",
        "STR Network": "https://www.youtube.com/@STRNetworkasia/",		
		"緯來新聞網": "https://www.youtube.com/@videolandnews/",
        "灿星官方频道": "https://www.youtube.com/@CanxingMediaOfficialChannel/",
        "陕西广播电视台官方频道": "https://www.youtube.com/@chinashaanxitvofficialchan2836/videos",		
        "北京廣播電視台生活頻道": "https://www.youtube.com/@Brtvofficialchannel/"		
    },
    "🔥直播頻道🔥,#genre#": {
	},
	"🎥電影頻道🎥,#genre#": {
	},

    "🎬影劇頻道🎬,#genre#": {	
        "戲說台灣": "https://www.youtube.com/@TWStoryTV/",
		"車庫娛樂": "https://www.youtube.com/@GaragePlay/",
	    "CCTV纪录": "https://www.youtube.com/@CCTVDocumentary/",
	    "大愛劇場 DaAiDrama": "https://www.youtube.com/@DaAiDrama/",	
        "台視時光機": "https://www.youtube.com/@TTVClassic/",
        "中視經典戲劇": "https://www.youtube.com/@ctvdrama_classic/",
        "中天快點看劇": "https://www.youtube.com/@CtiDrama/",		
        "華視戲劇頻道": "https://www.youtube.com/@cts_drama/",
        "民視戲劇館": "https://www.youtube.com/@FTVDRAMA/",
        "四季線上4gTV": "https://www.youtube.com/@4gTV_online/",	
        "三立電視 SET TV": "https://www.youtube.com/@SETTV/",
        "三立華劇 SET Drama": "https://www.youtube.com/@SETdrama/",
        "三立台劇 SET Drama": "https://www.youtube.com/@setdramatw/",	
        "終極系列": "https://www.youtube.com/@KOONERETURN/",
        "TVBS劇在一起": "https://www.youtube.com/@tvbsdrama/",
        "TVBS戲劇 女兵日記 女力報到": "https://www.youtube.com/@tvbs-1587/",	
        "八大劇樂部": "https://www.youtube.com/@gtv-drama/",
        "GTV DRAMA English": "https://www.youtube.com/@gtvdramaenglish/",
        "萌萌愛追劇": "https://www.youtube.com/@mengmengaizhuijuminidrama/",	
        "龍華電視": "https://www.youtube.com/@ltv_tw/",
        "Studio886": "https://www.youtube.com/@Studio886tw/",
        "GaragePlay 車庫娛樂": "https://www.youtube.com/@GaragePlay/",		
        "Vidol TV": "https://youtube.com/@vidoltv?si=wc0vxpCHtEVhigyf",		
        "緯來戲劇台": "https://www.youtube.com/@Vldrama43/",
        "緯來育樂台": "https://www.youtube.com/@maxtv71/videos",		
        "愛爾達綜合台": "https://www.youtube.com/@ELTAWORLD/",
        "愛爾達影劇台": "https://www.youtube.com/@eltadrama/",
        "VBL Series": "https://www.youtube.com/@variety_between_love/",
        "甄嬛传全集": "https://www.youtube.com/@LegendofConcubineZhenHuan/videos",
        "周周劇有料": "https://www.youtube.com/@WeeklyDramaScoop/",
        "影视剧汇踪": "https://www.youtube.com/@影视剧汇踪/",		
        "精选大剧": "https://www.youtube.com/@精选大剧/videos",		
        "百纳经典独播剧场": "https://www.youtube.com/@BainationTVSeriesOfficial/",
        "华录百納熱播劇場": "https://www.youtube.com/@Baination/",
        "影视剧汇踪": "https://www.youtube.com/@%E5%BD%B1%E8%A7%86%E5%89%A7%E6%B1%87%E8%B8%AA/",
        "iQIYI TW": "https://www.youtube.com/@iQIYITW/",			
        "iQIYI 爱奇艺": "https://www.youtube.com/@iQIYIofficial/",
        "iQIYI Show Giải Trí Vietnam": "https://www.youtube.com/@iQIYI_ShowGi%E1%BA%A3iTr%C3%ADVietnam/videos",		
        "iQIYI Indonesia": "https://www.youtube.com/@iQIYIIndonesia/",
        "爱奇艺大电影": "https://www.youtube.com/@iQIYIMOVIETHEATER/",
        "iQIYI 慢綜藝": "https://www.youtube.com/@iQIYILifeShow/",		
        "iQIYI 潮綜藝": "https://www.youtube.com/@iQIYISuperShow/",
        "iQIYI 爆笑宇宙": "https://www.youtube.com/@iQIYIHappyWorld/",		
        "MangoTV Shorts": "https://www.youtube.com/@MangoTVShorts/videos",
        "MangoTV English": "https://www.youtube.com/@MangoTVEnglishOfficial/videos",
        "MangoTV Malaysia": "https://www.youtube.com/@MangoTVMalaysia/",		
        "芒果TV古裝劇場": "https://www.youtube.com/@TVMangoTVCostume-yw1hj/videos",	
        "芒果TV青春剧场": "https://www.youtube.com/@MangoTVDramaOfficial/",	
        "芒果TV季风频道": "https://www.youtube.com/@MangoMonsoon/",	
        "芒果TV推理宇宙": "https://youtube.com/@mangotv-mystery?si=CRrdrZLRFBy4GXtQ",
        "芒果TV大電影劇場": "https://www.youtube.com/@MangoC-TheatreChannel/",
        "芒果TV心动": "https://www.youtube.com/@MangoTVSparkle/",	
        "CCTV电视剧": "https://www.youtube.com/@CCTVDrama/",	
        "SMG上海电视台官方频道": "https://www.youtube.com/@SMG-Official/",
        "SMG上海东方卫视欢乐频道": "https://www.youtube.com/@SMG-Comedy/",
        "SMG电视剧": "https://www.youtube.com/@SMGDrama/",
        "老广一起睇": "https://www.youtube.com/@老广一起睇/",
        "GC影視": "https://www.youtube.com/@gctv99/",		
        "安徽衛視官方頻道": "https://www.youtube.com/@chinaanhuitvofficialchanne8354/",	
        "中国东方卫视官方频道": "https://www.youtube.com/@SMGDragonTV/",
        "北京广播电视台官方频道": "https://www.youtube.com/@Brtvofficialchannel/",
        "贵州卫视官方频道": "https://www.youtube.com/@gztvofficial/",
        "喜剧大联盟": "https://www.youtube.com/@SuperComedyLeague/",
        "China Zone 古裝劇場": "https://www.youtube.com/@ChinaZoneCostume/",
        "China Zone 剧乐部": "https://www.youtube.com/@ChinaZoneDrama/",
        "China Zone 流金岁月": "https://www.youtube.com/@ChinaZone-ClassicDrama/",
        "China Zone梦想剧场": "https://www.youtube.com/@ChinaZone-DreamDrama/",		
        "欢娱影视官方频道": "https://www.youtube.com/@chinahuanyuent.officialchannel/",
        "乐视视频官方频道": "https://www.youtube.com/@letvdramas/",		
        "正午阳光官方频道": "https://www.youtube.com/@DaylightEntertainmentDrama/",		
        "超級影迷 正版電影免費看": "https://www.youtube.com/@MegaFilmLovers/",
        "電影想飛 正版電影免費看": "https://www.youtube.com/@moviesintheair/",
        "MadHouse 免費電影": "https://www.youtube.com/@MadHouseFreeMovie/",
        "FAST 免費電影": "https://www.youtube.com/@FASTMOVIE168/",		
        "SMG音乐频道": "https://www.youtube.com/@SMGMusic/"				
    },
    "👶小朋友頻道👶,#genre#": {
        "Muse木棉花-TW": "https://www.youtube.com/@MuseTW/",	
        "Muse木棉花-闔家歡": "https://www.youtube.com/@Muse_Family/",
		"YOYOTV": "https://www.youtube.com/@yoyotvebc/",
        "momokids親子台": "https://www.youtube.com/@momokidsYT/",
        "Bebefinn 繁體中文 - 兒歌": "https://www.youtube.com/@Bebefinn繁體中文/",
        "寶貝多米-兒歌童謠-卡通動畫-經典故事": "https://www.youtube.com/@Domikids_CN/",
        "會說話的湯姆貓家族": "https://www.youtube.com/@TalkingFriendsCN/",
        "瑪莎與熊": "https://www.youtube.com/@MashaBearTAIWAN/",	
        "碰碰狐 鯊魚寶寶": "https://www.youtube.com/@Pinkfong繁體中文/",
        "碰碰狐 Pinkfong Baby Shark 儿歌·故事": "https://www.youtube.com/@Pinkfong简体中文/",	
        "寶寶巴士": "https://www.youtube.com/@BabyBusTC/",
        "Miliki Family - 繁體中文 - 兒歌": "https://www.youtube.com/@MilikiFamily_Chinese/",	
        "貝樂虎-幼兒動畫-早教启蒙": "https://www.youtube.com/@BarryTiger_Education_CN/",	
        "貝樂虎兒歌-童謠歌曲": "https://www.youtube.com/@barrytiger_kidssongs/",
        "貝樂虎-兒歌童謠-卡通動畫-經典故事": "https://www.youtube.com/@barrytiger_zh/",
        "小猪佩奇": "https://www.youtube.com/@PeppaPigChineseOfficial/",
        "Kids Songs - Giligilis": "https://www.youtube.com/@KidsSongs6868/",
        "超級汽車-卡通動畫": "https://www.youtube.com/@Supercar_Cartoon/",	
        "神奇鸡仔": "https://www.youtube.com/@como_cn/",
        "Yameme閻小妹": "https://www.youtube.com/@yameme511/",		
        "朱妮托尼 - 动画儿歌": "https://www.youtube.com/@JunyTonyCN/",	
        "Ani-One中文官方動畫頻道": "https://www.youtube.com/@AniOneAnime/",
        "Lv.99 Animation Club": "https://www.youtube.com/@Lv.99AnimationClub/",
        "嘀嘀漫畫站": "https://www.youtube.com/@嘀嘀漫畫站DidiComic/",			
        "嗶哩嗶哩動畫Anime Made By Bilibili": "https://www.youtube.com/@MadeByBilibili/",
        "Ani-Mi動漫迷動畫頻道": "https://www.youtube.com/@AnimiforAnime/",		
        "回歸線娛樂": "https://www.youtube.com/@tropicsanime/",
        "愛奇藝國漫": "https://www.youtube.com/@iQIYIAnimation/",
        "艾瑪愛學習": "https://www.youtube.com/@EmmaLearning/",		
        "超人官方 YouTube 粵語頻道": "https://www.youtube.com/@ultraman_cantonese_official/"				
    },
    "🤸🏾‍體育頻道🤸🏾‍,#genre#": {
        "愛爾達體育家族": "https://www.youtube.com/@ELTASPORTSHD/",
        "緯來體育台": "https://www.youtube.com/@vlsports/",
	    "公視體育": "https://www.youtube.com/@pts_sports/",
	    "getwin sport": "https://www.youtube.com/@GetWinSport/",		
        "庫泊運動賽事": "https://www.youtube.com/@coopersport-live/",	
        "智林體育台": "https://www.youtube.com/@oursport_tv1/",
        "博斯體育台": "https://www.youtube.com/@Sportcasttw/",	
        "HOP Sports": "https://www.youtube.com/@HOPSports/",
        "DAZN 台灣": "https://www.youtube.com/@DAZNTaiwan/",	
        "動滋Sports": "https://www.youtube.com/@Sport_sa_taiwan/",
        "GoHoops": "https://www.youtube.com/@GoHoops/",
        "P.LEAGUE+": "https://www.youtube.com/@PLEAGUEofficial/",
        "TPBL": "https://www.youtube.com/@TPBL.Basketball/",		
        "CPBL 中華職棒": "https://www.youtube.com/@CPBL/",
        "CBC籃球聯盟": "https://www.youtube.com/@cbc726/",
        "MAX籃球聯盟": "https://www.youtube.com/@MAX-mv8mr/",		
        "TPVL 台灣職業排球聯盟": "https://www.youtube.com/@tpvl.official/",
        "籃海運動": "https://www.youtube.com/@pbe1772/",		
        "Body Sports  名衍行銷運動頻道": "https://www.youtube.com/@bodysports9644/",		
        "日本B聯盟": "https://www.youtube.com/@b.leagueinternational/",
        "GAORA SPORTS": "https://www.youtube.com/@GAORATV/",		
        "MotoGP": "https://www.youtube.com/@motogp/",
        "The Savannah Bananas": "https://www.youtube.com/@TheSavannahBananas/",
        "WCW": "https://www.youtube.com/@WCW/",		
        "BattleBots": "https://www.youtube.com/@BattleBots/",
        "WWE": "https://www.youtube.com/@WWE/",
	    "WWE Vault": "https://www.youtube.com/@WWEVault/"   
    },
	"🎵音樂頻道🎵,#genre#": {
	    "Dreamy R&B Jazz": "https://www.youtube.com/@DreamyRBJazz/",
		"RB音樂": "https://www.youtube.com/@RB音乐/",
		"深情慢歌": "https://www.youtube.com/@深情慢歌/",
		"釋放壓力音樂": "https://www.youtube.com/@Tranquilgentlemusic/",
		"一秒舒眠音樂": "https://www.youtube.com/@healingmeditation1272/",
		"超舒眠音樂": "https://www.youtube.com/@calmsleep-c5d/",
		"4kTQ music": "https://www.youtube.com/@4kTQ-music/",
	    "心动 Radio": "https://www.youtube.com/@%E5%BF%83%E5%8A%A8Radio/",		
	    "Eight无限": "https://www.youtube.com/@eight-audio/",
	    "相信音樂BinMusic": "https://www.youtube.com/@binmusictaipei/",
	    "周杰倫 Jay Chou": "https://www.youtube.com/@jaychou/",		
	    "Sony Music Entertainment Hong Kong": "https://www.youtube.com/@sonymusichk/",		
	    "Hot TV": "https://www.youtube.com/@hotfm976/",
	    "时间节拍 Melody": "https://www.youtube.com/@%E6%97%B6%E9%97%B4%E8%8A%82%E6%8B%8DMelody/",
	    "孤心旋律": "https://www.youtube.com/@GuXinXuanlu68/",		
	    "KKBOX 华语新歌周榜": "https://www.youtube.com/@KKBOX-baidu6868/",
	    "Douyin Chill": "https://www.youtube.com/@DouyinChill-xr2yk/",
	    "生活乐章": "https://www.youtube.com/@生活乐章/",	    
	    "抖音音樂台": "https://www.youtube.com/@douyinyinyuetai/",
	    "青春音乐铺": "https://www.youtube.com/@青春音乐铺/",
	    "水月琴音": "https://www.youtube.com/@Shuiyueqinyin/",	    
	    "Cherry 葵": "https://www.youtube.com/@Cherriexin/",
	    "Kanata Ch. 天音かなた": "https://www.youtube.com/@AmaneKanata/",		
	    "CMIX Chill Mix": "https://www.youtube.com/@ChillMix-CMIX/",		
	    "「KING AMUSEMENT CREATIVE」公式チャンネル": "https://www.youtube.com/@KAC_official/",
	    "FOR FUN RADIO TIME Music channel": "https://www.youtube.com/@FORFUNRADIOTIME-Relax/",		
	    "Mellowbeat Seeker": "https://www.youtube.com/@mellowbeatseeker/",
	    "The Good Life Radio x Sensual Musique": "https://www.youtube.com/@TheGoodLiferadio/",	
        "Best of Mix": "https://www.youtube.com/@bestofmixlive/",
        "Rock FM": "https://www.youtube.com/@rockfm1/",
        "Radio Mix": "https://www.youtube.com/@liveradiomix/",
        "Too Music": "https://www.youtube.com/@toomusicc/",		
	    "Radio Hits Music": "https://www.youtube.com/@LiveMusicRadio/",
	    "Dark City Sounds": "https://www.youtube.com/@darkcitysounds/",
	    "Pop Japan Music": "https://www.youtube.com/@PopJapanMusic-du6su/",
	    "Tokyo Sound Rank": "https://www.youtube.com/@TokyoSoundRank98/",
	    "MEET48 Global": "https://www.youtube.com/@MEET48Global/",		
	    "KING AMUSEMENT CREATIVE": "https://www.youtube.com/@KAC_official/"		
    },		
	"🌪️台灣啟示錄頻道🌪️,#genre#": {
	},
    "📡風景頻道📡,#genre#": {
        "TW Live Cam": "https://www.youtube.com/@DanjiangBridge/",	
        "和平島公園即時影像": "https://www.youtube.com/@和平島公園即時影像/",
		"台北觀光即時影像": "https://www.youtube.com/@taipeitravelofficial/",
		"陽明山國家公園": "https://www.youtube.com/@ymsnpinfo/",
		"大新店有線電視": "https://www.youtube.com/@CGNEWS8888/",
		"新北旅客 New Taipei Tour": "https://www.youtube.com/@ntctour/",
		"紅樹林有線電視": "https://www.youtube.com/@紅樹林有線電視-h7k/",
		"necoast nsa": "https://www.youtube.com/@necoastnsa2903/",
		"野柳即時影像": "https://www.youtube.com/@野柳即時影像/",
		"遊桃園 Taoyuan Travel": "https://www.youtube.com/@TaoyuanTravel/",
		"雪霸國家公園 Shei-Pa National Park": "https://www.youtube.com/@spnp852/",
		"交通部觀光署 參山風管處": "https://www.youtube.com/@trimtnsa/",
		"大玩台中 臺中觀光旅遊局": "https://www.youtube.com/@大玩台中-臺中觀光旅/",
		"台灣即時影像監視器": "https://www.youtube.com/@twipcam/",
		"Amos YANG": "https://www.youtube.com/@feng52/",
		"國家森林遊樂區即時影像": "https://www.youtube.com/@fancarecreation/",
		"阿里山國家風景區管理處": "https://www.youtube.com/@Alishannsa/",
		"大台南新聞": "https://www.youtube.com/@大台南新聞南天地方新/",
		"內政部國家公園署台江國家公園管理處": "https://www.youtube.com/@taijiangnationalpark/",
		"高雄旅遊網": "https://www.youtube.com/@travelkhh/",
		"茂林國家風景區": "https://www.youtube.com/@茂林國家風景區/",
		"南喃夕語": "https://www.youtube.com/@thesouth.2022/",
		"ktnpworld": "https://www.youtube.com/@ktnpworld/",
		"斯爾本科技有限公司": "https://www.youtube.com/@Suburban-Security/",
		"花蓮縣政府觀光處七星潭風景區": "https://www.youtube.com/@花蓮縣政府觀光處七星/",
		"東部海岸國家風景管理處": "https://www.youtube.com/@eastcoastnsa0501/",
		"Amazing Taitung 台東就醬玩": "https://www.youtube.com/@taitungamazing7249/",
		"ervnsa": "https://www.youtube.com/@ervnsa/",
		"交通部觀光署澎湖國家風景區管理處": "https://www.youtube.com/@交通部觀光署澎湖國家/",		
		"樂遊金門": "https://www.youtube.com/@kinmentravel/",
		"馬祖國家風景區": "https://www.youtube.com/@matsunationalscenicarea9539/"		
    },
	"💖精選音樂頻道💖,#genre#": {
	},
	"🏛️政論頻道🏛️,#genre#": {
        "壹電視NEXT TV": "https://www.youtube.com/@壹電視NEXTTV/",
        "庶民大頭家": "https://www.youtube.com/@庶民大頭家/",
        "TVBS 優選頻道": "https://www.youtube.com/@tvbschannel/",
        "街頭麥克風": "https://www.youtube.com/@street-mic/",
        "全球大視野": "https://www.youtube.com/@全球大視野Global_Vision/",
        "鄉民監察院": "https://www.youtube.com/@FTControlYuan/",		
        "民視讚夯": "https://www.youtube.com/@FTV_Forum/",
        "新台派上線": "https://www.youtube.com/@NewTaiwanonline/",	
        "94要客訴": "https://www.youtube.com/@94politics/",	
        "大新聞大爆卦": "https://www.youtube.com/@大新聞大爆卦HotNewsTalk/",	
        "新聞大白話": "https://www.youtube.com/@tvbstalk/",
        "國民大會": "https://www.youtube.com/@tvbscitizenclub/",	
        "中時新聞網": "https://www.youtube.com/@ChinaTimes/",
        "中天深喉嚨": "https://www.youtube.com/@ctitalkshow/",		
        "新聞挖挖哇！": "https://www.youtube.com/@newswawawa/",	
        "前進新台灣": "https://www.youtube.com/@SETTaiwanGo/",
        "哏傳媒": "https://www.youtube.com/@funseeTW/",
        "董事長開講": "https://www.youtube.com/@dongsshow/",
        "政經關不了": "https://www.youtube.com/@truevoiceoftaiwan/",			
        "57爆新聞": "https://www.youtube.com/@57BreakingNews/",
        "關鍵時刻": "https://www.youtube.com/@ebcCTime/",
		"郭正亮頻道": "https://www.youtube.com/@Guovision-TV/",
        "新聞龍捲風": "https://www.youtube.com/@新聞龍捲風NewsTornado/",		
        "頭條開講": "https://www.youtube.com/@頭條開講HeadlinesTalk/",		
	    "少康戰情室": "https://www.youtube.com/@tvbssituationroom/",
        "文茜的世界周報": "https://www.youtube.com/@tvbssisysworldnews/",
        "萬事通事務所": "https://www.youtube.com/@sciencewillwin/",		
        "中天深喉嚨": "https://www.youtube.com/@ctitalkshow/",
        "品觀點": "https://www.youtube.com/@pinviewmedia/",
        "52新聞聚樂部 ": "https://www.youtube.com/@52newsclub/",		
        "觀點": "https://www.youtube.com/@%E8%A7%80%E9%BB%9E/",		
        "金臨天下": "https://www.youtube.com/@tvbsmoney/"		
    },
	"🥱購物🥱,#genre#": {
        "海豚多媒體": "https://www.youtube.com/@24811001/",
        "玉麟網路電視台": "https://www.youtube.com/@YuLinNetworkTelevision/",		
        "寶島文化台": "https://www.youtube.com/@bdtvbest/",
        "三聖電視台": "https://www.youtube.com/@tsimtv-01/",		
        "桐瑛台中電視臺": "https://www.youtube.com/@%E6%A1%90%E7%91%9B%E5%8F%B0%E4%B8%AD%E9%9B%BB%E8%A6%96%E8%87%BA/",
        "桐瑛虎尾電視臺": "https://www.youtube.com/@%E6%A1%90%E7%91%9B%E8%99%8E%E5%B0%BE%E9%9B%BB%E8%A6%96%E8%87%BA/",
        "桐瑛台南電視臺": "https://www.youtube.com/@%E6%A1%90%E7%91%9B%E5%8F%B0%E5%8D%97%E9%9B%BB%E8%A6%96%E8%87%BA/",		
        "momo購物一台": "https://www.youtube.com/@momoch4812/",
	    "momo購物二台": "https://www.youtube.com/@momoch3571/",
	    "ViVa TV美好家庭購物": "https://www.youtube.com/@ViVaTVtw/",
	    "Live東森購物台": "https://www.youtube.com/@HotsaleTV/"		
    },
    "🤬國會🤬,#genre#": {
        "國會頻道": "https://www.youtube.com/@parliamentarytv/"
    },
    "👀宗教👀,#genre#": {
        "淨土宗": "https://www.youtube.com/@plbtp/",
        "中華傳統文化教育中心": "https://www.youtube.com/@520wtv/",
        "修心時刻": "https://www.youtube.com/@Practicetime7/",
        "華藏衛視直播2台": "https://www.youtube.com/@hztv2212/",		
        "佛光山梵唄讚頌團": "https://www.youtube.com/@VG_MUSICAL/",
        "生命電視台": "https://www.youtube.com/@LIFETV_HaiTao/",		
        "遠東良友": "https://www.youtube.com/@febc/"		
    },
    "👏教育👏,#genre#": {	
        "龍騰高中聲": "https://www.youtube.com/@LTeduForStudent/",
        "Oziter茅": "https://www.youtube.com/@oziter/",		
        "ABC Learning English": "https://www.youtube.com/@ABCLearningEnglish/",		
        "學習粵語": "https://www.youtube.com/@CantoneseClass101/",
        "南非荷蘭語": "https://www.youtube.com/@AfrikaansPod101/",
        "學習印地語": "https://www.youtube.com/@hindipod101/",
        "學習菲律賓語": "https://www.youtube.com/@FilipinoPod101/",
        "學習烏爾都語": "https://www.youtube.com/@UrduPod101/",
        "學習德語": "https://www.youtube.com/@Germanpod101/",
        "學習土耳其語": "https://www.youtube.com/@TurkishClass101/",
        "學習阿拉伯語": "https://www.youtube.com/@ArabicPod101/",
        "學習瑞典語": "https://www.youtube.com/@SwedishPod101/",
        "學習挪威語": "https://www.youtube.com/@NorwegianClass101/",
        "學習希伯來語": "https://www.youtube.com/@HebrewPod101/",
        "學習希臘語": "https://www.youtube.com/@GreekPod101/",
        "學習波蘭語": "https://www.youtube.com/@PolishPod101/",
        "學習日文": "https://www.youtube.com/@JapanesePod101/",
        "學習中文": "https://www.youtube.com/@ChineseClass101/",
        "學習匈牙利語": "https://www.youtube.com/@HungarianPod101/",
        "學習芬蘭語": "https://www.youtube.com/@FinnishPod101/",
        "學習荷蘭語": "https://www.youtube.com/@DutchPod101/",
        "學習韓語": "https://www.youtube.com/@KoreanClass101/",
        "學習法語": "https://www.youtube.com/@frenchpod101/",		
        "學習波斯語": "https://www.youtube.com/@PersianPod101/"		
    }
}

# 若某些頻道在美國伺服器 100% 報 404，請在此手動填入連結保底
MANUAL_LINKS = {
    "🔥直播頻道🔥,#genre#": [
  "龍華電影台,http://cdn8.veryfast.filegear-sg.me/163189/lhdy",
  "AXN,http://211.23.95.147:18881/live/67_h265.ts",
  "AXN,http://8.218.84.3:8885/live/LxWcScuQ6WphaELY4DhkKm8SIv7_ZgNIJtNvFurqphvyqxUIU84OjKVCwFxMq9iUvKU-Aw4PFwAvIn8K7Du4mC3015hsvpEc6eDcUk4mvopVQtp6nlzWobtnuBKKBituajEnyybNUk-LLZEz69RaUMqbXBLyh-lF8fRE4fJXcMPgYzQG49BxTCq6sYH71TC25maGuC_HSHA1bjjwZbRGfsOfP5RaGSXmqARhRI8fOmwQanwlbDSyKKEhMVZYVYjZoaJVJ7dWgBK-kMlE3TgwoA.m3u8?u=1756878715",
  "HBO,http://211.23.95.147:18881/live/65_h265.ts",
  "好萊塢電影,http://211.23.95.147:18881/live/68_h265.ts",
  "東森綜合,http://211.23.95.147:18881/live/32_h265.ts",
  "東森綜合,http://8.218.84.3:8885/live/LxWcScuQ6WphaELY4DhkKm8SIv7_ZgNIJtNvFurqphvyqxUIU84OjKVCwFxMq9iUHWMHCytb2VBItbRCwo0LyqP7JL5zoJwS4YNNznemr_YdtSKhh6NNAwR9PzzP461sjhlssLp3lK6UJ8-tnuwG8CbBxKI1dg3OfG2PGsVIQaseJXA6DBTaS0MuVPFR_aOdPVW3LH5YhV9dtBSNyWyJZiz6NyMdgyeWK4kjvnkBH2wPAT52wt91Db438hm8mDpNXQRutSpHIsBlvrQktzdyMg.m3u8?u=1756878715",
  "東森洋片,http://52xinghe.top/smmmt.php?id=ettvwestern&h=52xinghe.top&p=7788",
  "東森電影,http://52xinghe.top/smmmt.php?id=ettvmovie&h=52xinghe.top&p=7788",
  "東森電影,https://stream1.freetv.fun/9ecfcb8a9664c6c431a55482b76f3938b0d9a7950977e496728c12cd174c15d4.ctv",
  "東森電影,http://8.218.84.3:8885/live/LxWcScuQ6WphaELY4DhkKm8SIv7_ZgNIJtNvFurqphvyqxUIU84OjKVCwFxMq9iUHWMHCytb2VBItbRCwo0LykwxMoUHpMM_iP4852Z3fkyk8zLr_cHdtRNfGHcdy6CBHw-Gsla_fUeSZd5w4Wac0uJflUo3jPx-syZub8WoZXN8RiuExRGYFHshahLkcavYsTA0xVX1vv5-7vKJhs-n7zwpfIB1QcisXHnKxS0kd5Hze8xeJra-LdG_RCTOfdFcvx03TGauO_eJLMAVKIyz9Q.m3u8?u=1756878715",
  "東森洋片,http://8.218.84.3:8885/live/LxWcScuQ6WphaELY4DhkKm8SIv7_ZgNIJtNvFurqphvyqxUIU84OjKVCwFxMq9iUHWMHCytb2VBItbRCwo0LyueGr-6I5WurXyVzCPErAn1bIY0Xo0oD4WTTmWvbwk0WlRLAiSKjvvk1qlTgn_rvKqmndIlkvXOsgb2pLGqYWlBY4bum9lzyFDqrQV09sm9mH8Norh0gOkpeKmnKhs7l0EGvOTpy8B5LkIDy-zcVjSoBzBiSy2SqAL9FF4LqSM_pIZGYBuWkuHd68RQGk25yig.m3u8?u=1756878715",
  "東森洋片,https://stream1.freetv.fun/370cab0cec03dfee84b4b9acdb92141b83e88fa04e4571824bb2153b55e69f5c.m3u8",
  "三立台灣,http://211.23.95.147:18881/live/29_h265.ts",
  "智林體育台,http://iptv.4666888.xyz/iptv2A.php?id=5",
  "愛奇異,http://iptv.4666888.xyz/iptv2A.php?id=21",
  "華藝中文台,http://iptv.4666888.xyz/iptv2A.php?id=37",
  "金光布袋戲,http://iptv.4666888.xyz/iptv2A.php?id=38",
  "夢工廠動畫,http://iptv.4666888.xyz/iptv2A.php?id=40",
  "靖洋戲劇台,http://iptv.4666888.xyz/iptv2A.php?id=42",
  "TVBS新聞台,http://iptv.4666888.xyz/iptv2A.php?id=43",
  "非凡新聞台,http://iptv.4666888.xyz/iptv2A.php?id=44",
  "龍華電影台,http://iptv.4666888.xyz/iptv2A.php?id=45",
  "民視綜藝台,http://iptv.4666888.xyz/iptv2A.php?id=46",
  "TVBS精彩台,http://iptv.4666888.xyz/iptv2A.php?id=47",
  "東森電影台,http://iptv.4666888.xyz/iptv2A.php?id=48",
  "MOMO親子台,http://iptv.4666888.xyz/iptv2A.php?id=49",
  "ROCK ACTION,http://iptv.4666888.xyz/iptv2A.php?id=50",
  "民視影劇台,http://iptv.4666888.xyz/iptv2A.php?id=53",
  "緯來電影台,http://iptv.4666888.xyz/iptv2A.php?id=54",
  "民視,http://iptv.4666888.xyz/iptv2A.php?id=55",
  "靖天電影台,http://iptv.4666888.xyz/iptv2A.php?id=56",
  "恐怖電影台,http://iptv.4666888.xyz/iptv2A.php?id=59",
  "龍華洋片台,http://iptv.4666888.xyz/iptv2A.php?id=60",
  "綜藝大贏家,http://iptv.4666888.xyz/iptv2A.php?id=65",
  "台视,https://live.catvod.com/live.php?token=815e29cc8c01a08e58b6bc1f59358054ad9a6f8a4f65ad2ebe535c7da196a77e&id=ttv_taiwan",
  "中视,https://live.catvod.com/live.php?token=815e29cc8c01a08e58b6bc1f59358054ad9a6f8a4f65ad2ebe535c7da196a77e&id=zhongshihd_twn",
  "华视,https://live.catvod.com/live.php?token=815e29cc8c01a08e58b6bc1f59358054ad9a6f8a4f65ad2ebe535c7da196a77e&id=ctshd_twn",
  "公视,https://live.catvod.com/live.php?token=815e29cc8c01a08e58b6bc1f59358054ad9a6f8a4f65ad2ebe535c7da196a77e&id=ctv_taiwan",
  "三立台湾台,https://live.catvod.com/live.php?token=815e29cc8c01a08e58b6bc1f59358054ad9a6f8a4f65ad2ebe535c7da196a77e&id=sanlitaiwan",
  "三立综合台,https://live.catvod.com/live.php?token=815e29cc8c01a08e58b6bc1f59358054ad9a6f8a4f65ad2ebe535c7da196a77e&id=sanlizhonghe",
  "三立都会台,https://live.catvod.com/live.php?token=815e29cc8c01a08e58b6bc1f59358054ad9a6f8a4f65ad2ebe535c7da196a77e&id=sanlidouhui_twn",
  "中视,https://live.catvod.com/live.php?token=815e29cc8c01a08e58b6bc1f59358054ad9a6f8a4f65ad2ebe535c7da196a77e&id=zhongshihd_twn",
  "TVBS新闻台,https://live.catvod.com/live.php?token=815e29cc8c01a08e58b6bc1f59358054ad9a6f8a4f65ad2ebe535c7da196a77e&id=tvbs_n",
  "TVBSHD,https://live.catvod.com/live.php?token=815e29cc8c01a08e58b6bc1f59358054ad9a6f8a4f65ad2ebe535c7da196a77e&id=tvbs",
  "中天新闻,https://live.catvod.com/live.php?token=815e29cc8c01a08e58b6bc1f59358054ad9a6f8a4f65ad2ebe535c7da196a77e&id=ctinews",
  "中天综合,https://live.catvod.com/live.php?token=815e29cc8c01a08e58b6bc1f59358054ad9a6f8a4f65ad2ebe535c7da196a77e&id=ctizhonghe",
	],
	"⚠️新聞頻道⚠️,#genre#": [
		"東森新聞,https://www.youtube.com/watch?v=V1p33hqPrUk",		
		"TVBS新聞,https://www.youtube.com/watch?v=m_dhMSvUCIc",
        "中天新聞,https://www.youtube.com/watch?v=vr3XyVCR4T0",
		"【TTV LIVE 台視直播】台視,https://www.youtube.com/watch?v=uDqQo8a7Xmk&rco=1&ab_channel=TTVLIVE%E5%8F%B0%E8%A6%96%E7%9B%B4%E6%92%AD",        
    ],
	"🎵音樂頻道🎵,#genre#": [
        "【周杰倫】音樂時光機,https://www.youtube.com/watch?v=q8hw5oKCDp4",
		"【五月天】不間斷霸佔你耳朵,https://www.youtube.com/live/R62E7cFWX6o"
    ],
	"💖精選音樂頻道💖,#genre#": [
	],
	"🌪️台灣啟示錄頻道🌪️,#genre#": [
	],
	"🤸🏾‍體育頻道🤸🏾‍,#genre#": [
	 "NBA,http://mytvstream.net:8080/live/30550113/30550113/20946.m3u8",
	 "红牛运动,http://rbmn-live.akamaized.net/hls/live/590964/BoRB-AT/master_1660.m3u8",
     "红牛运动,http://rbmn-live.akamaized.net/hls/live/590964/BoRB-AT/master_6660.m3u8",
     "红牛运动,https://rbmn-live.akamaized.net/hls/live/590964/BoRB-AT/master_3360.m3u8",
     "篮球专场,https://live.ottiptv.cc/huya/27949551",
	 "瑜伽专场,https://live.ottiptv.cc/huya/20753449",
	],
    "☣️綜藝頻道☣️,#genre#": [
	"全民星攻略,video://https://www.faintv.com/channel/18310",
	"點相II破局,video://https://www.faintv.com/channel/22633",
    "請問今晚住誰家,video://http://www.faintv.com/channel/20309",
	"請問今晚住誰家,https://live2-faintv.cdn.hinet.net/live_HLS/cstv09.stream/playlist.m3u8?token=U9-QVuEvok68s5AkU11ycQ&expires=1774966033",
    "花甲少年趣旅行,video://http://www.faintv.com/channel/20559",
	"花甲少年趣旅行,https://live2-faintv.cdn.hinet.net/live_HLS/cstv10.stream/playlist.m3u8?token=-qMZ3kxfyk5-1uCPUZ5m3w&expires=1774965993",
    "台灣啟示錄,video://http://www.faintv.com/channel/18254",
	"台灣啟示錄,https://live4-faintv.cdn.hinet.net/live_HLS/M061.stream/playlist.m3u8?token=sue2gGCMlkbwi-uwl1a7HQ&expires=1774965914",
	],
    "👶小朋友頻道👶,#genre#": [
        "名侦探柯南,https://live.ottiptv.cc/huya/30080236",
        "火影忍者,https://live.ottiptv.cc/huya/29465866",
        "海贼王,https://live.ottiptv.cc/huya/29982634",
        "精灵宝可梦,https://live.ottiptv.cc/huya/23749096",
		"七龍珠,https://live.ottiptv.cc/huya/11601966",
        "头文字D,https://live.ottiptv.cc/huya/11352889",
		"哆啦A梦动漫,https://live.iill.top/huya/11601963",
        "航海王,https://live.iill.top/huya/16913382",
        "七龍珠,https://live.iill.top/huya/11601966",
	    "火影忍者,http://cfss.cc/cdn/huya/29465866.flv",
        "海贼王,http://cfss.cc/cdn/huya/29982634.flv",
        "宫崎骏系列,http://cfss.cc/cdn/huya/21059614.flv",
		"【Muse木棉花】新哆啦A夢,https://www.youtube.com/watch?v=gnDok9gtopw",
		"【Muse木棉花】TOM and JERRY in NY,https://www.youtube.com/watch?v=rEKifG2XUZg",
		"【Muse木棉花】我們這一家,https://www.youtube.com/watch?v=e1gbvCkwxFE",
		"【Muse木棉花】間諜家家酒,https://www.youtube.com/watch?v=hdgvUXazd1w",
        "【Muse木棉花】BanG Dream! It's MyGO,https://www.youtube.com/watch?v=iZ44tIBbfH0",
        "【Muse木棉花】獵人HUNTER×HUNTER,https://www.youtube.com/watch?v=UVouDle2jHc",		
        "【Muse木棉花】葬送的芙莉蓮,https://www.youtube.com/watch?v=v1ZmBzh9pxs",
        "【Muse木棉花】JOJO的奇妙冒險,https://www.youtube.com/watch?v=4_JnTQCn9Kg",
        "【Muse木棉花】進擊的巨人,https://www.youtube.com/watch?v=GlVvyu7jehk",				
        "【Muse木棉花】蠟筆小新劇場版系列,https://www.youtube.com/watch?v=tBYG62NeTdU",		
        "【Muse木棉花】蠟筆小新TV版,https://www.youtube.com/watch?v=ENnjj7jQ23g",
        "【Muse木棉花】中華一番,https://www.youtube.com/watch?v=mRCXonM5ru8",
        "【Ani-One】遊戲王－怪獸之決鬥,https://www.youtube.com/watch?v=SHngPS2mRac",
		"【回歸線娛樂】凍牌~地下麻將鬥牌錄,https://www.youtube.com/watch?v=FsCrGmYmw9w",
		"【回歸線娛樂】凡爾賽玫瑰,https://www.youtube.com/watch?v=TAS_TszmpTY",		
        "【回歸線娛樂】真珠美人魚,https://www.youtube.com/watch?v=BLag8MOBUg8",
    ],
"🎥電影頻道🎥,#genre#": [
"八點檔,https://www.goodiptv.club/huya/880261",
"不擠影院,https://www.goodiptv.club/huya/11352897",
"五福星,https://www.goodiptv.club/huya/11282233",
"王晶,http://cfss.cc/cdn/huya/11602058.flv",
"王晶,http://cfss.cc/cdn/huya/11602058.flv",
"王晶,http://live.iill.top/huya.php?id=11602058",
"王晶,https://live.iill.top/huya.php?id=11602058",
"王晶,https://live.iill.top/huya/11602058",
"王晶,https://live.ottiptv.cc/huya/11602058",
"王晶,https://www.goodiptv.club/huya/11602058",
"王寶强,https://live.ottiptv.cc/huya/30080251",
"功夫片,http://cfss.cc/cdn/huya/11352941.flv",
"功夫片,http://cfss.cc/cdn/huya/11352941.flv",
"功夫片,http://live.iill.top/huya.php?id=11352941",
"功夫片,https://live.iill.top/huya.php?id=11352941",
"功夫片,https://live.iill.top/huya/11352941",
"功夫片,https://www.goodiptv.club/huya/11352941",
"古天樂,http://live.iill.top/huya.php?id=29982675",
"古天樂,https://live.iill.top/huya.php?id=29982675",
"古天樂,https://live.iill.top/huya/29982675",
"古天樂,https://live.ottiptv.cc/huya/29982675",
"古天樂,https://www.goodiptv.club/huya/11602041",
"盜墓,https://www.goodiptv.club/huya/11352913",
"犯罪片,https://live.ottiptv.cc/huya/30080165",
"犯罪片,https://www.goodiptv.club/huya/11352974",
"玄幻,http://cfss.cc/cdn/huya/11342414.flv",
"玄幻,https://www.goodiptv.club/huya/11342414",
"邓超,https://live.ottiptv.cc/huya/11336592",
"宇宙,https://www.goodiptv.club/huya/11342428",
"成龍,http://74.91.26.218:82/live/vlcl.m3u8",
"成龍,http://74.91.26.218:82/live/vlcl.m3u8",
"成龍,http://cfss.cc/cdn/huya/11342386.flv",
"成龍,https://live.ottiptv.cc/huya/11342386",
"成龍,https://lunbo.ottiptv.cc//1382736841",
"成龍,https://www.goodiptv.club/huya/11342386",
"杀手片系列,https://live.ottiptv.cc/huya/23728689",
"死神來了,https://www.goodiptv.club/huya/11352903",
"西部片系列,https://live.ottiptv.cc/huya/30080177",
"体育片系列,https://live.ottiptv.cc/huya/23864480",
"吴京,https://live.ottiptv.cc/huya/11602077",
"吴镇宇,https://live.ottiptv.cc/huya/23865096",
"张卫健,https://live.ottiptv.cc/huya/11342423",
"李連杰,http://cfss.cc/cdn/huya/11342390.flv",
"李連杰,http://cfss.cc/cdn/huya/11342390.flv",
"李連杰,http://live.iill.top/huya.php?id=11342390",
"李連杰,https://live.iill.top/huya.php?id=11342390",
"李連杰,https://live.iill.top/huya/11342390",
"李連杰,https://live.ottiptv.cc/huya/11342390",
"李連杰,https://www.goodiptv.club/huya/11342390",
"沈騰,http://cfss.cc/cdn/huya/11601968.flv",
"沈騰,http://live.iill.top/huya.php?id=11601968",
"沈騰,https://live.iill.top/huya.php?id=11601968",
"沈騰,https://live.ottiptv.cc/huya/11601968",
"沈騰,https://www.goodiptv.club/huya/11601968",
"災難片,https://live.ottiptv.cc/huya/23728647",
"災難片,https://www.goodiptv.club/huya/11602075",
"狄仁杰,http://live.iill.top/huya.php?id=30080229",
"狄仁杰,https://live.iill.top/huya.php?id=30080229",
"狄仁杰,https://live.iill.top/huya/30080229",
"周星馳,http://63.141.230.178:82/gslb/zbdq5.m3u8?id=hyzxc",
"周星馳,http://63.141.230.178:82/gslb/zbdq5.m3u8?id=lbzxc",
"周星馳,http://74.91.26.218:82/live/vlzxc.m3u8",
"周星馳,http://74.91.26.218:82/live/vlzxc.m3u8",
"周星馳,http://cfss.cc/cdn/huya/11336587.flv",
"周星馳,https://live.ottiptv.cc/huya/11336587",
"周星馳,https://www.goodiptv.club/huya/11336587",
"周星馳,https://www.goodiptv.club/huya/11342412",
"周海媚,https://www.goodiptv.club/huya/11279247",
"周潤發,http://222.186.39.38:8000/587078/index.m3u8",
"周潤發,http://63.141.230.178:82/gslb/zbdq5.m3u8?id=lbzrf",
"周潤發,http://74.91.26.218:82/live/vlzrf.m3u8",
"周潤發,http://cfss.cc/cdn/huya/11342387.flv",
"周潤發,https://live.ottiptv.cc/huya/11342387",
"周潤發,https://www.goodiptv.club/huya/11342387",
"周潤發,http://74.91.26.218:82/live/vlzrf.m3u8",
"国产,http://cfss.cc/cdn/huya/11352973.flv",
"奇幻片系列,https://live.ottiptv.cc/huya/26355847",
"怪獸,https://live.ottiptv.cc/huya/29982674",
"怪獸,https://www.goodiptv.club/huya/21059554",
"怪獸,https://www.goodiptv.club/huya/21059577",
"林正英,http://63.141.230.178:82/gslb/zbdq5.m3u8?id=hylzy",	
"林正英,http://74.91.26.218:82/live/vllzy.m3u8",
"林正英,http://74.91.26.218:82/live/vllzy.m3u8",
"林正英,https://live.ottiptv.cc/huya/11342421",
"林正英,https://www.goodiptv.club/huya/11342421",
"枪战片系列,https://live.ottiptv.cc/huya/21059579",
"武侠片,http://cfss.cc/cdn/huya/11342427.flv",
"武侠片,https://live.ottiptv.cc/huya/29982611",
"武俠,https://www.goodiptv.club/huya/11342427",
"邱淑貞,https://www.goodiptv.club/huya/11352949",
"金庸武侠,http://cfss.cc/cdn/huya/11342435.flv",
"金庸武侠,http://live.iill.top/huya.php?id=11342435",
"金庸武侠,https://live.iill.top/huya.php?id=11342435",
"金庸武侠,https://live.iill.top/huya/11342435",
"陆小凤,https://live.ottiptv.cc/huya/11342427",
"陈小春,https://live.ottiptv.cc/huya/11336719",
"冒险片,https://live.ottiptv.cc/huya/21059566",
"哆啦A梦,https://live.iill.top/huya/11601963",
"复仇片,https://live.ottiptv.cc/huya/29982645",
"战争片,https://live.ottiptv.cc/huya/21059618",
"星球片,https://live.ottiptv.cc/huya/30080234",
"洪金寶,http://74.91.26.218:82/live/vlhjb.m3u8",
"洪金寶,http://cfss.cc/cdn/huya/11279251.flv",
"洪金寶,https://live.ottiptv.cc/huya/11279251",
"洪金寶,https://www.goodiptv.club/huya/11279251",
"洪金寶,http://74.91.26.218:82/live/vlhjb.m3u8",
"科幻片,https://live.ottiptv.cc/huya/11352965",
"穿越片,https://live.ottiptv.cc/huya/29465892",
"英雄片,https://live.ottiptv.cc/huya/11601980",
"音乐片,https://live.ottiptv.cc/huya/23860057",
"香港片,https://live.ottiptv.cc/huya/29982660",
"徐克,https://live.ottiptv.cc/huya/11352909",
"徐克,https://www.goodiptv.club/huya/11352909",
"徐峥,https://live.ottiptv.cc/huya/11602043",
"恐怖片,https://live.ottiptv.cc/huya/24884334",
"恐怖片,https://lunbo.ottiptv.cc//24066336",
"校园片,https://live.ottiptv.cc/huya/11352934",
"海盜,https://www.goodiptv.club/huya/21059595",
"热门片,https://live.ottiptv.cc/huya/880261",
"爱情片,https://live.ottiptv.cc/huya/29982639",
"竞速片,https://live.ottiptv.cc/huya/29982635",
"馬東錫,https://live.ottiptv.cc/huya/21059556",
"高分片,https://live.ottiptv.cc/huya/23902225",
"高分動作,https://www.goodiptv.club/huya/11352884",
"高能反轉,https://www.goodiptv.club/huya/11352887",
"動作電影,https://www.goodiptv.club/huya/11602077",
"國產,https://www.goodiptv.club/huya/11352973",
"國產懸疑,https://www.goodiptv.club/huya/11342395",
"強森,http://cfss.cc/cdn/huya/21059581.flv",
"強森,http://live.iill.top/huya.php?id=21059581",
"強森,https://live.iill.top/huya.php?id=21059581",
"強森,https://live.ottiptv.cc/huya/21059581",
"強森,https://www.goodiptv.club/huya/21059581",
"悬疑片,https://live.ottiptv.cc/huya/21059530",
"惊悚片,https://live.ottiptv.cc/huya/26355802",
"推薦,https://www.goodiptv.club/huya/11602041",
"救援,https://www.goodiptv.club/huya/21059594",
"梁家輝,https://live.ottiptv.cc/huya/11342429",
"梁家輝,https://www.goodiptv.club/huya/11342429",
"盗墓片,https://live.ottiptv.cc/huya/11601981",
"許氏三傑,https://www.goodiptv.club/huya/11602033",
"許冠英,https://www.goodiptv.club/huya/11601972",
"谍战片,https://live.ottiptv.cc/huya/26355810",
"郭富城,https://live.ottiptv.cc/huya/20985865",
"黄百鸣,http://74.91.26.218:82/live/vlhbm.m3u8",
"黄渤,http://cfss.cc/cdn/huya/11352876.flv",
"黄渤,http://live.iill.top/huya.php?id=11352876",
"黄渤,https://live.iill.top/huya.php?id=11352876",
"黄渤,https://live.iill.top/huya/11352876",
"黄渤,https://live.ottiptv.cc/huya/11352876",
"喜羊羊与灰太狼,https://live.iill.top/huya/23865080",
"喜劇片,http://74.91.26.218:82/live/vlxj.m3u8",
"喜劇片,https://live.ottiptv.cc/huya/11602044",
"喜劇片,https://www.goodiptv.club/huya/11352877",
"喜劇片,https://www.goodiptv.club/huya/11602044",
"喜劇片,https://www.goodiptv.club/huya/21059580",
"喪屍片,https://live.ottiptv.cc/huya/24314160",
"喪屍片,https://www.goodiptv.club/huya/21059578",
"斯坦森,http://cfss.cc/cdn/huya/21059588.flv",
"斯坦森,https://live.ottiptv.cc/huya/21059588",
"斯坦森,https://www.goodiptv.club/huya/21059588",
"曾江,https://www.goodiptv.club/huya/11601981",
"港片,https://www.goodiptv.club/huya/11602043",
"盜墓,https://www.goodiptv.club/huya/21059552",
"短片,https://live.ottiptv.cc/huya/17098448",
"硬汉片,https://live.ottiptv.cc/huya/23864973",
"賀歲,https://www.goodiptv.club/huya/11601971",
"賀歲片,http://live.iill.top/huya.php?id=11601986",
"賀歲片,https://live.iill.top/huya.php?id=11601986",
"賀歲片,https://live.iill.top/huya/11601986",
"賀歲片,https://live.ottiptv.cc/huya/11601986",
"賀歲片,https://www.goodiptv.club/huya/11601986",
"超異能族,https://www.goodiptv.club/huya/21059586",
"馮小剛,https://www.goodiptv.club/huya/11352906",
"黃百鳴,http://74.91.26.218:82/live/vlhbm.m3u8",
"黃渤,https://www.goodiptv.club/huya/11352876",
"黑幫片,https://www.goodiptv.club/huya/11336719",
"黑幫鬥爭,https://www.goodiptv.club/huya/11342419",
"搞笑恐怖,https://www.goodiptv.club/huya/11601960",
"搞笑喜劇,https://www.goodiptv.club/huya/11342423",
"經典港片,https://www.goodiptv.club/huya/11352965",
"罪犯,https://www.goodiptv.club/huya/11352962",
"電影院,http://63.141.230.178:82/gslb/zbdq5.m3u8?id=lbcl",
"嫣然影廳,https://www.goodiptv.club/huya/11601977",
"槍戰,https://www.goodiptv.club/huya/21059579",
"漫威,https://www.goodiptv.club/huya/11602034",
"甄子丹,http://live.iill.top/huya.php?id=11352935",
"甄子丹,https://live.iill.top/huya.php?id=11352935",
"甄子丹,https://live.iill.top/huya/11352935",
"甄子丹,https://live.ottiptv.cc/huya/11352935",
"甄子丹,https://www.goodiptv.club/huya/11352935",
"蜘蛛俠,https://www.goodiptv.club/huya/21059599",
"僵尸片,https://live.ottiptv.cc/huya/11352917",
"劉德華,http://74.91.26.218:82/live/vlldh.m3u8",
"劉德華,http://cfss.cc/cdn/huya/11342424.flv",
"劉德華,http://live.iill.top/huya.php?id=11342424",
"劉德華,https://live.iill.top/huya.php?id=11342424",
"劉德華,https://live.iill.top/huya/11342424",
"劉德華,https://live.ottiptv.cc/huya/11342424",
"劉德華,https://www.goodiptv.club/huya/11342424",
"劉德華,http://74.91.26.218:82/live/vlldh.m3u8",
"熱血,https://www.goodiptv.club/huya/11352934",
"戰爭片,https://www.goodiptv.club/huya/21059592",
"戰爭片,https://www.goodiptv.club/huya/21059574",
"諜戰片,https://www.goodiptv.club/huya/21059585",
"諜戰片,https://www.goodiptv.club/huya/21059587",
"鏢行天下,https://www.goodiptv.club/huya/11352969",
"警匪片,https://www.goodiptv.club/huya/11352886",
"警匪片,https://live.ottiptv.cc/huya/30041512",
"歡笑影院,https://www.goodiptv.club/huya/11352894",
"變形金剛,https://www.goodiptv.club/huya/21059596",
]
}

# ==========================================
# ✅ TXT 導入工具
# ==========================================
def load_txt(path):
    items = []
    if not os.path.exists(path):
        print(f"[WARN] 找不到 {path}")
        return items

    with open(path, "r", encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith("#"):
                continue
            if "," not in line:
                continue
            items.append(line)
    return items

# ==========================================
# ✅ 導入指定頻道
# ==========================================

# 💖 精選音樂頻
MANUAL_LINKS.setdefault("💖精選音樂頻道💖,#genre#", [])
MANUAL_LINKS["💖精選音樂頻道💖,#genre#"].extend(
    load_txt("data/music.txt")
)

# 🌪️ 台灣啟示錄
MANUAL_LINKS.setdefault("🌪️台灣啟示錄頻道🌪️,#genre#", [])
MANUAL_LINKS["🌪️台灣啟示錄頻道🌪️,#genre#"].extend(
    load_txt("data/tonador.txt")
)

print("✅ TXT 已導入完成")
print("精選音樂數量：", len(MANUAL_LINKS["💖精選音樂頻道💖,#genre#"]))
print("台灣啟示錄數量：", len(MANUAL_LINKS["🌪️台灣啟示錄頻道🌪️,#genre#"]))

# ==========================================
# 2. 地標優化與翻譯邏輯
# ==========================================
LANDMARK_MAP = {
    "Shoushan Lovers": "壽山情人觀景台", "Lianchihtan": "蓮池潭", "Lotus Pond": "蓮池潭",
    "Cijin": "旗津", "Baling": "巴陵大橋", "Shihmen Reservoir": "石門水庫",
    "Fenqihu": "奮起湖", "Eryanping": "二延平", "Sanxiantai": "三仙台", "Chaikou": "綠島柴口"
}

def extract_best_title(v_title, nickname):
    # 國會特殊處理
    if "國會頻道" in nickname:
        segments = re.split(r'[\|\-\—\–]', v_title)
        return f"【國會頻道】{segments[0].strip()}" if len(segments) > 1 else f"【國會頻道】{v_title}"

    # 風景品牌標準化
    brand = nickname
    for b in ["高雄", "台北", "桃園", "新北", "阿里山", "東部海岸", "MangoTV"]:
        if b in nickname: brand = b; break

    # 清理地標名稱
    clean_title = re.sub(r'[【\[\(].*?[】\]\)]', '', v_title).strip()
    
    # 嘗試從標題提取中文核心
    chinese_parts = "".join(re.findall(r'[\u4e00-\u9fa5]+', clean_title))
    for n in ["即時影像", "直播", "官方", "桃園", "台北", "高雄", "新北", brand]:
        chinese_parts = chinese_parts.replace(n, "")
        
    landmark = chinese_parts if len(chinese_parts) >= 2 else ""
    
    # 英文翻譯救援
    if not landmark:
        for eng, chi in LANDMARK_MAP.items():
            if eng.lower() in v_title.lower(): landmark = chi; break
            
    return f"【{brand}】{landmark if landmark else clean_title[:15]}"

# ==========================================
# ⭐⭐⭐ 核心：專抓真正 LIVE（穩定修正版）⭐⭐⭐
# ==========================================
def get_live_info():

    now = int(time.time())

    ydl_opts = {
        'quiet': True,
        'skip_download': True,
        'ignoreerrors': True,

        # ⭐ 保持快速模式
        'extract_flat': True,

        'playlist_items': '1-50',
        'no_warnings': True,

        # ❌ 不要用 match_filter
        # 很多 LIVE metadata 不完整會被濾掉

        'extra_headers': {
            'User-Agent': 'Mozilla/5.0',
            'Accept-Language': 'zh-TW,zh;q=0.9'
        }
    }

    final_output = []
    seen = set()

    for genre, channels in CATEGORIES.items():

        genre_list = []

        # ==========================================
        # 手動源
        # ==========================================
        if genre in MANUAL_LINKS:
            for item in MANUAL_LINKS[genre]:

                try:
                    url = item.split(',')[-1].strip()

                    if url not in seen:
                        genre_list.append(item)
                        seen.add(url)

                except:
                    pass

        print(f"▶ 掃描分類: {genre}")

        with yt_dlp.YoutubeDL(ydl_opts) as ydl:

            for nickname, base_url in channels.items():

                # ==========================================
                # ⭐ LIVE 路徑
                # ==========================================
                paths = [
                    f"{base_url}live",
                    base_url,
                    f"{base_url}streams"
                ]

                found_live = False

                for path in paths:

                    try:
                        info = ydl.extract_info(path, download=False)

                        if not info:
                            continue

                        entries = info.get("entries") or []

                        # ==========================================
                        # 處理每個影片
                        # ==========================================
                        for e in entries:

                            if not e:
                                continue

                            # ==========================================
                            # 基本資料
                            # ==========================================
                            raw_title = e.get("title") or ""
                            title = raw_title.upper()

                            vid = e.get("id")

                            if not vid:
                                continue

                            # ==========================================
                            # LIVE 狀態
                            # ==========================================
                            live_status = e.get("live_status")
                            is_live = e.get("is_live", False)
                            was_live = e.get("was_live", False)

                            # ==========================================
                            # ⭐ 真正 LIVE 判定（放寬）
                            # ==========================================
                            real_live = (
                                is_live
                                or live_status == "is_live"
                            )

                            if not real_live:
                                continue

                            # 已結束直播
                            if was_live:
                                continue

                            # ==========================================
                            # 排除 Shorts / Premiere
                            # ==========================================
                            if "SHORTS" in title:
                                continue

                            if "PREMIERE" in title:
                                continue

                            if "預告" in raw_title:
                                continue

                            # ==========================================
                            # 時間過濾（放寬版）
                            # ==========================================
                            release_timestamp = e.get("release_timestamp")
                            timestamp = e.get("timestamp")

                            live_time = release_timestamp or timestamp

                            if live_time:

                                hours = (now - live_time) / 3600

                                # ⭐ 超過 72 小時才排除
                                # 避免 24H 新聞 LIVE 被濾掉
                                if hours > 72:
                                    continue

                            # ==========================================
                            # 排除普通影片
                            # ==========================================
                            duration = e.get("duration")

                            # 太短通常是假 LIVE / 普通影片
                            if duration and duration < 300:
                                continue

                            # ==========================================
                            # 建立網址
                            # ==========================================
                            url = f"https://www.youtube.com/watch?v={vid}"

                            if url in seen:
                                continue

                            # ==========================================
                            # 名稱處理
                            # ==========================================
                            name = extract_best_title(raw_title, nickname)

                            genre_list.append(f"{name},{url}")
                            seen.add(url)

                            found_live = True

                            print(f"✅ LIVE: {name}")
                            print(url)

                        # 有抓到 LIVE 就不用繼續其他路徑
                        if found_live:
                            break

                    except Exception as ex:
                        print(f"❌ 掃描失敗: {nickname} | {path}")
                        continue

        # ==========================================
        # 輸出分類
        # ==========================================
        if genre_list:
            final_output.append(genre)
            final_output.extend(genre_list)
            final_output.append("")

    return final_output


# ==========================================
# 執行輸出
# ==========================================
if __name__ == "__main__":
    results = get_live_info()

    with open("live_list.txt", "w", encoding="utf-8") as f:
        f.write("\n".join(results).strip() + "\n")

    print("\n✅ LIVE 清單已產出：live_list.txt")
