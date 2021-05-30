redis = require('redis') 
https = require ("ssl.https") 
serpent = dofile("./library/serpent.lua") 
json = dofile("./library/JSON.lua") 
JSON  = dofile("./library/dkjson.lua")
URL = require('socket.url')  
utf8 = require ('lua-utf8') 
database = redis.connect('127.0.0.1', 6379) 
id_server = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
--------------------------------------------------------------------------------------------------------------
local AutoSet = function() 
local create = function(data, file, uglify)  
file = io.open(file, "w+")   
local serialized   
if not uglify then  
serialized = serpent.block(data, {comment = false, name = "Info"})  
else  
serialized = serpent.dump(data)  
end    
file:write(serialized)    
file:close()  
end  
if not database:get(id_server..":token") then
io.write('\27[0;31m\n ارسل لي توكن البوت الان ↓ :\n⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ٴ\n\27')
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
print('\27[0;31m⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ٴ\n التوكن غير صحيح تاكد منه ثم ارسله')
else
io.write('\27[0;31m تم حفظ التوكن بنجاح \n⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ٴ\n27[0;39;49m')
database:set(id_server..":token",token)
end 
else
print('\27[0;35m⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ٴ \n لم يتم حفظ التوكن ارسل لي التوكن الان')
end 
os.execute('lua TuBacK.lua')
end
if not database:get(id_server..":SUDO:ID") then
io.write('\27[0;35m\n ارسل لي ايدي المطور الاساسي ↓ :\n⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ٴ\n\27[0;33;49m')
local SUDOID = io.read()
if SUDOID ~= '' then
io.write('\27[1;35m تم حفظ ايدي المطور الاساسي \n⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ٴ\n27[0;39;49m')
database:set(id_server..":SUDO:ID",SUDOID)
else
print('\27[0;31m⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ٴ \n لم يتم حفظ ايدي المطور الاساسي ارسله مره اخره')
end 
os.execute('lua TuBacK.lua')
end
if not database:get(id_server..":SUDO:USERNAME") then
io.write('\27[1;31m ↓ ارسل معرف المطور الاساسي :\n SEND ID FOR SIDO : \27[0;39;49m')
local SUDOUSERNAME = io.read():gsub('@','')
if SUDOUSERNAME ~= '' then
io.write('\n\27[1;34m تم حفظ معرف المطور :\n\27[0;39;49m')
database:set(id_server..":SUDO:USERNAME",'@'..SUDOUSERNAME)
else
print('\n\27[1;34m لم يتم حفظ معرف المطور :')
end 
os.execute('lua TuBacK.lua')
end
local create_config_auto = function()
config = {
token = database:get(id_server..":token"),
SUDO = database:get(id_server..":SUDO:ID"),
UserName = database:get(id_server..":SUDO:USERNAME"),
 }
create(config, "./Info.lua")   
end 
create_config_auto()
token = database:get(id_server..":token")
SUDO = database:get(id_server..":SUDO:ID")
install = io.popen("whoami"):read('*a'):gsub('[\n\r]+', '') 
print('\n\27[1;34m done send :')
file = io.open("TuBacK", "w")  
file:write([[
#!/usr/bin/env bash
cd $HOME/TuBacK
token="]]..database:get(id_server..":token")..[["
while(true) do
rm -fr ../.telegram-cli
if [ ! -f ./tg ]; then
echo "ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯"
echo "TG IS NOT FIND IN FILES BOT"
echo "ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯"
exit 1
fi
if [ ! $token ]; then
echo "ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯"
echo -e "\e[1;36mTOKEN IS NOT FIND IN FILE INFO.LUA \e[0m"
echo "ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯"
exit 1
fi
echo -e "\033[38;5;208m"
echo -e "                                                  "
echo -e "\033[0;00m"
echo -e "\e[36m"
./tg -s ./TuBacK.lua -p PROFILE --bot=$token
done
]])  
file:close()  
file = io.open("tk", "w")  
file:write([[
#!/usr/bin/env bash
cd $HOME/TuBacK
while(true) do
rm -fr ../.telegram-cli
screen -S TuBacK -X kill
screen -S TuBacK ./TuBacK
done
]])  
file:close() 
os.execute('rm -fr $HOME/.telegram-cli')
end 
local serialize_to_file = function(data, file, uglify)  
file = io.open(file, "w+")  
local serialized  
if not uglify then   
serialized = serpent.block(data, {comment = false, name = "Info"})  
else   
serialized = serpent.dump(data) 
end  
file:write(serialized)  
file:close() 
end 
local load_redis = function()  
local f = io.open("./Info.lua", "r")  
if not f then   
AutoSet()  
else   
f:close()  
database:del(id_server..":token")
database:del(id_server..":SUDO:ID")
end  
local config = loadfile("./Info.lua")() 
return config 
end 
_redis = load_redis()  
--------------------------------------------------------------------------------------------------------------
print([[                                   
⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯

                      Source TuBacK                   
                   Devloper : @VlVlVI      
                 Channel : @TUBAKTEAM    
   ________                __                       __         
  |        \              |  \                     |  \        
  \▓▓▓▓▓▓▓▓__      __   | ▓▓ ____     ______     | ▓▓     __  
   |  ▓▓   |      \   |  | ▓▓     \   |       \   | ▓▓     /  \ 
   |  ▓▓   | ▓▓   | ▓▓  | ▓▓▓▓▓▓▓\   \▓▓▓▓▓▓\  | ▓▓   _/▓▓
   |  ▓▓   | ▓▓   | ▓▓  | ▓▓    |▓▓          ▓▓  | ▓▓   ▓▓  
   |  ▓▓   | ▓▓ __/ ▓▓  | ▓▓ __/ ▓▓    ▓▓▓▓▓▓▓  | ▓▓▓▓▓▓\  
   |  ▓▓   \ ▓▓     ▓▓  | ▓▓    ▓▓  \▓▓    ▓▓▓   \ ▓▓   \▓▓\ 
   \  ▓▓    \ ▓▓▓▓▓▓    \▓▓▓▓▓▓▓    \▓▓▓▓▓▓▓    \ ▓▓    \▓▓\                                      


⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯

]])
sudos = dofile("./Info.lua") 
SUDO = tonumber(sudos.SUDO)
sudo_users = {SUDO}
bot_id = sudos.token:match("(%d+)")  
token = sudos.token 
--------------------------------------------------------------------------------------------------------------
io.popen("mkdir File_Bot") 
io.popen("cd File_Bot && rm -rf commands.lua.1") 
io.popen("cd File_Bot && rm -rf commands.lua.2") 
io.popen("cd File_Bot && rm -rf commands.lua.3") 
io.popen("cd File_Bot && wget https://raw.githubusercontent.com/SRCTuBacK/Files_TuBacK/main/File_Bot/commands.lua") 
t = "\27[35m".."\n: جاري تنظيف المجموعات الوهمية يرجى الانتظار - \n⎯ ⎯ ⎯ ⎯  ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯\n"..'\27[m'
i = 0
for v in io.popen('ls File_Bot'):lines() do
if v:match(".lua$") then
i = i + 1
t = t.."\27[39m"..i.."\27[36m".." - \27[10;32m"..v..",\27[m \n"
end
end
print(t)
function vardump(value)  
print(serpent.block(value, {comment=false}))   
end 
sudo_users = {SUDO,332581832,909438744}   
function SudoBot(msg)  
local TuBacK = false  
for k,v in pairs(sudo_users) do  
if tonumber(msg.sender_user_id_) == tonumber(v) then  
TuBacK = true  
end  
end  
return TuBacK  
end 
function DevTuBacK(msg) 
local hash = database:sismember(bot_id.."Dev:AhMd:2", msg.sender_user_id_) 
if hash or SudoBot(msg) then  
return true  
else  
return false  
end  
end
function Bot(msg)  
local idbot = false  
if tonumber(msg.sender_user_id_) == tonumber(bot_id) then  
idbot = true    
end  
return idbot  
end
function Sudo(msg) 
local hash = database:sismember(bot_id..'Sudo:User', msg.sender_user_id_) 
if hash or SudoBot(msg) or DevTuBacK(msg) or Bot(msg)  then  
return true  
else  
return false  
end  
end
function CoSu(msg)
local hash = database:sismember(bot_id..'CoSu'..msg.chat_id_, msg.sender_user_id_) 
if hash or SudoBot(msg) or DevTuBacK(msg) or Sudo(msg) or Bot(msg)  then   
return true 
else 
return false 
end 
end
function BasicConstructor(msg)
local hash = database:sismember(bot_id..'Basic:Constructor'..msg.chat_id_, msg.sender_user_id_) 
if hash or SudoBot(msg) or DevTuBacK(msg) or Sudo(msg) or CoSu(msg) or Bot(msg)  then   
return true 
else 
return false 
end 
end
function Constructor(msg)
local hash = database:sismember(bot_id..'Constructor'..msg.chat_id_, msg.sender_user_id_) 
if hash or SudoBot(msg) or DevTuBacK(msg) or Sudo(msg) or BasicConstructor(msg) or CoSu(msg) or Bot(msg)  then       
return true    
else    
return false    
end 
end
function Manager(msg)
local hash = database:sismember(bot_id..'Manager'..msg.chat_id_,msg.sender_user_id_)    
if hash or SudoBot(msg) or DevTuBacK(msg) or Sudo(msg) or BasicConstructor(msg) or Constructor(msg) or CoSu(msg) or Bot(msg)  then       
return true    
else    
return false    
end 
end
function cleaner(msg)
local hash = database:sismember(bot_id.."VlVlVI:MN:TF"..msg.chat_id_,msg.sender_user_id_)    
if hash or SudoBot(msg) or DevTuBacK(msg) or Sudo(msg) or BasicConstructor(msg) or CoSu(msg) or Bot(msg)  then       
return true    
else    
return false    
end 
end
function Mod(msg)
local hash = database:sismember(bot_id..'Mod:User'..msg.chat_id_,msg.sender_user_id_)    
if hash or SudoBot(msg) or DevTuBacK(msg) or Sudo(msg) or BasicConstructor(msg) or Constructor(msg) or Manager(msg) or CoSu(msg) or Bot(msg)  then       
return true    
else    
return false    
end 
end
function Special(msg)
local hash = database:sismember(bot_id..'Special:User'..msg.chat_id_,msg.sender_user_id_) 
if hash or SudoBot(msg) or DevTuBacK(msg) or Sudo(msg) or BasicConstructor(msg) or Constructor(msg) or Manager(msg) or Mod(msg) or CoSu(msg) or Bot(msg)  then       
return true 
else 
return false 
end 
end

function CatchName(Name,Num) 
ChekName = utf8.sub(Name,0,Num) Name = ChekName return Name..'' 
end

function Can_or_NotCan(user_id,chat_id)
if tonumber(user_id) == tonumber(332581832) then  
var = true  
elseif tonumber(user_id) == tonumber(909438744) then
var = true  
elseif tonumber(user_id) == tonumber(SUDO) then
var = true  
elseif tonumber(user_id) == tonumber(bot_id) then
var = true  
elseif database:sismember(bot_id.."Dev:AhMd:2", user_id) then
var = true  
elseif database:sismember(bot_id..'Sudo:User', user_id) then
var = true  
elseif database:sismember(bot_id..'CoSu'..chat_id, user_id) then
var = true
elseif database:sismember(bot_id..'Basic:Constructor'..chat_id, user_id) then
var = true
elseif database:sismember(bot_id..'Biasic:Constructor'..chat_id, user_id) then
var = true
elseif database:sismember(bot_id..'Constructor'..chat_id, user_id) then
var = true  
elseif database:sismember(bot_id..'Manager'..chat_id, user_id) then
var = true  
elseif database:sismember(bot_id..'VlVlVI:MN:TF'..chat_id, user_id) then
var = true 
elseif database:sismember(bot_id..'Mod:User'..chat_id, user_id) then
var = true  
elseif database:sismember(bot_id..'Special:User'..chat_id, user_id) then  
var = true  
elseif database:sismember(bot_id..'Mamez:User'..chat_id, user_id) then  
var = true  
else  
var = false  
end  
return var
end 
function Rutba(user_id,chat_id)
if tonumber(user_id) == tonumber(332581832) then 
 var = 'مبرمج السورس'
 elseif tonumber(user_id) == tonumber(667869951) then  
var = "مطور السورس"  
elseif tonumber(user_id) == tonumber(SUDO) then
var = 'المطور الاساسي' 
 elseif database:sismember(bot_id.."Dev:AhMd:2", user_id) then 
var = "مطور اساسي" 
 elseif tonumber(user_id) == tonumber(bot_id) then  
var = 'البوت'
elseif database:sismember(bot_id..'Sudo:User', user_id) then
var = database:get(bot_id.."Sudo:Rd"..msg.chat_id_) or 'المطور'  
elseif database:sismember(bot_id..'CoSu'..chat_id, user_id) then
var = database:get(bot_id.."CoSu:Rd"..msg.chat_id_) or 'المالك'
elseif database:sismember(bot_id..'Basic:Constructor'..chat_id, user_id) then
var = database:get(bot_id.."BasicConstructor:Rd"..msg.chat_id_) or 'المنشئ اساسي'
elseif database:sismember(bot_id..'Constructor'..chat_id, user_id) then
var = database:get(bot_id.."Constructor:Rd"..msg.chat_id_) or 'المنشئ'  
elseif database:sismember(bot_id..'Manager'..chat_id, user_id) then
var = database:get(bot_id.."Manager:Rd"..msg.chat_id_) or 'المدير'  
elseif database:sismember(bot_id..'VlVlVI:MN:TF'..chat_id, user_id) then
var = 'منظف' 
elseif database:sismember(bot_id..'Mod:User'..chat_id, user_id) then
var = database:get(bot_id.."Mod:Rd"..msg.chat_id_) or 'الادمن'  
elseif database:sismember(bot_id..'Special:User'..chat_id, user_id) then  
var = database:get(bot_id.."Special:Rd"..msg.chat_id_) or 'المميز'  
else  
var = database:get(bot_id.."Memp:Rd"..msg.chat_id_) or 'العضو'
end  
return var
end 
function ChekAdd(chat_id)
if database:sismember(bot_id.."Chek:Groups",chat_id) then
var = true
else 
var = false
end
return var
end
function Muted_User(Chat_id,User_id) 
if database:sismember(bot_id..'Muted:User'..Chat_id,User_id) then
Var = true
else
Var = false
end
return Var
end
function Ban_User(Chat_id,User_id) 
if database:sismember(bot_id..'Ban:User'..Chat_id,User_id) then
Var = true
else
Var = false
end
return Var
end 
function GBan_User(User_id) 
if database:sismember(bot_id..'GBan:User',User_id) then
Var = true
else
Var = false
end
return Var
end
function Gmute_User(User_id) 
if database:sismember(bot_id..'Gmute:User',User_id) then
Var = true
else
Var = false
end
return Var
end
function AddChannel(User)
local var = true
if database:get(bot_id..'add:ch:id') then
local url , res = https.request("https://api.telegram.org/bot"..token.."/getchatmember?chat_id="..database:get(bot_id..'add:ch:id').."&user_id="..User);
data = json:decode(url)
if res ~= 200 or data.result.status == "left" or data.result.status == "kicked" then
var = false
end
end
return var
end

function dl_cb(a,d)
end
function getChatId(id)
local chat = {}
local id = tostring(id)
if id:match('^-100') then
local channel_id = id:gsub('-100', '')
chat = {ID = channel_id, type = 'channel'}
else
local group_id = id:gsub('-', '')
chat = {ID = group_id, type = 'group'}
end
return chat
end
function chat_kick(chat,user)
tdcli_function ({
ID = "ChangeChatMemberStatus",
chat_id_ = chat,
user_id_ = user,
status_ = {ID = "ChatMemberStatusKicked"},},function(arg,data) end,nil)
end
function send(chat_id, reply_to_message_id, text)
local TextParseMode = {ID = "TextParseModeMarkdown"}
tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = 1,from_background_ = 1,reply_markup_ = nil,input_message_content_ = {ID = "InputMessageText",text_ = text,disable_web_page_preview_ = 1,clear_draft_ = 0,entities_ = {},parse_mode_ = TextParseMode,},}, dl_cb, nil)
end
function DeleteMessage(chat,id)
tdcli_function ({
ID="DeleteMessages",
chat_id_=chat,
message_ids_=id
},function(arg,data) 
end,nil)
end
function PinMessage(chat, id)
tdcli_function ({
ID = "PinChannelMessage",
channel_id_ = getChatId(chat).ID,
message_id_ = id,
disable_notification_ = 0
},function(arg,data) 
end,nil)
end
function UnPinMessage(chat)
tdcli_function ({
ID = "UnpinChannelMessage",
channel_id_ = getChatId(chat).ID
},function(arg,data) 
end,nil)
end
local function GetChat(chat_id) 
tdcli_function ({
ID = "GetChat",
chat_id_ = chat_id
},cb, nil) 
end  
function GetApi(web) 
local info, res = https.request(web) 
local req = json:decode(info) if res ~= 200 then 
return false 
end 
if not req.ok then 
return false 
end 
return req 
end 
function SendText(chat_id, text, reply_to_message_id, markdown) 
send_api = "https://api.telegram.org/bot"..token 
local url = send_api.."/sendMessage?chat_id=" .. chat_id .. "&text=" .. URL.escape(text) 
if reply_to_message_id ~= 0 then 
url = url .. "&reply_to_message_id=" .. reply_to_message_id  
end 
if markdown == "md" or markdown == "markdown" then 
url = url.."&parse_mode=Markdown&disable_web_page_preview=true" 
elseif markdown == "html" then 
url = url.."&parse_mode=HTML" 
end 
return GetApi(url) 
end
function SendInline(chat_id,text,keyboard,inline,reply_id) 
local response = {} 
response.keyboard = keyboard 
response.inline_keyboard = inline 
response.resize_keyboard = true 
response.one_time_keyboard = false 
response.selective = false  
local send_api = "https://api.telegram.org/bot"..token.."/sendMessage?chat_id="..chat_id.."&text="..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(JSON.encode(response)) 
if reply_id then 
send_api = send_api.."&reply_to_message_id="..reply_id 
end 
return GetApi(send_api) 
end
function EditMsg(chat_id, message_id, text, markdown) local send_api = "https://api.telegram.org/bot"..token.."/editMessageText?chat_id="..chat_id.."&message_id="..message_id.."&text="..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true" return GetApi(send_api)  end
function pin(channel_id, message_id, disable_notification) 
tdcli_function ({ 
ID = "PinChannelMessage", 
channel_id_ = getChatId(channel_id).ID, 
message_id_ = message_id, 
disable_notification_ = disable_notification 
}, function(arg ,data)
vardump(data)
end ,nil) 
end

function sendAudio(chat_id,reply_id,audio,title,caption,func)
tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageAudio",
audio_ = GetInputFile(audio),
duration_ = "",
title_ = title or "",
performer_ = "سورس توباك الرسمي",
caption_ = caption or ""
}},func or dl_cb,nil)
end


function getInputFile(file) 
if file:match('/') then infile = {ID = "InputFileLocal", path_ = file} elseif file:match('^%d+$') then infile = {ID = "InputFileId", id_ = file} else infile = {ID = "InputFilePersistentId", persistent_id_ = file} end return infile 
end
function ked(User_id,Chat_id)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..Chat_id.."&user_id="..User_id)
end
function s_api(web) 
local info, res = https.request(web) local req = json:decode(info) if res ~= 200 then return false end if not req.ok then return false end return req 
end 
local function sendText(chat_id, text, reply_to_message_id, markdown) 
send_api = "https://api.telegram.org/bot"..token local url = send_api..'/sendMessage?chat_id=' .. chat_id .. '&text=' .. URL.escape(text) if reply_to_message_id ~= 0 then url = url .. '&reply_to_message_id=' .. reply_to_message_id  end if markdown == 'md' or markdown == 'markdown' then url = url..'&parse_mode=Markdown' elseif markdown == 'html' then url = url..'&parse_mode=HTML' end return s_api(url)  
end
local function Send(chat_id, reply_to_message_id, text)
local TextParseMode = {ID = "TextParseModeMarkdown"}
tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = 1,from_background_ = 1,reply_markup_ = nil,input_message_content_ = {ID = "InputMessageText",text_ = text,disable_web_page_preview_ = 1,clear_draft_ = 0,entities_ = {},parse_mode_ = TextParseMode,},}, dl_cb, nil)
end
function send_inline_key(chat_id,text,keyboard,inline,reply_id) 
local response = {} response.keyboard = keyboard response.inline_keyboard = inline response.resize_keyboard = true response.one_time_keyboard = false response.selective = false  local send_api = "https://api.telegram.org/bot"..token.."/sendMessage?chat_id="..chat_id.."&text="..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(JSON.encode(response)) if reply_id then send_api = send_api.."&reply_to_message_id="..reply_id end return s_api(send_api) 
end
local function GetInputFile(file)  
local file = file or ""   if file:match('/') then  infile = {ID= "InputFileLocal", path_  = file}  elseif file:match('^%d+$') then  infile = {ID= "InputFileId", id_ = file}  else  infile = {ID= "InputFilePersistentId", persistent_id_ = file}  end return infile 
end
local function sendRequest(request_id, chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, callback, extra) 
tdcli_function ({  ID = request_id,    chat_id_ = chat_id,    reply_to_message_id_ = reply_to_message_id,    disable_notification_ = disable_notification,    from_background_ = from_background,    reply_markup_ = reply_markup,    input_message_content_ = input_message_content,}, callback or dl_cb, extra) 
end
local function sendAudio(chat_id,reply_id,audio,title,caption)  
tdcli_function({ID="SendMessage",  chat_id_ = chat_id,  reply_to_message_id_ = reply_id,  disable_notification_ = 0,  from_background_ = 1,  reply_markup_ = nil,  input_message_content_ = {  ID="InputMessageAudio",  audio_ = GetInputFile(audio),  duration_ = '',  title_ = title or '',  performer_ = '',  caption_ = caption or ''  }},dl_cb,nil)
end  
local function sendVideo(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, video, duration, width, height, caption, cb, cmd)    
local input_message_content = { ID = "InputMessageVideo",      video_ = getInputFile(video),      added_sticker_file_ids_ = {},      duration_ = duration or 0,      width_ = width or 0,      height_ = height or 0,      caption_ = caption    }    sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd)  
end
function sendDocument(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, document, caption, dl_cb, cmd) 
tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = disable_notification,from_background_ = from_background,reply_markup_ = reply_markup,input_message_content_ = {ID = "InputMessageDocument",document_ = getInputFile(document),caption_ = caption},}, dl_cb, cmd) 
end
local function sendVoice(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, voice, duration, waveform, caption, cb, cmd)  
local input_message_content = {   ID = "InputMessageVoice",   voice_ = getInputFile(voice),  duration_ = duration or 0,   waveform_ = waveform,    caption_ = caption  }  sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd) 
end
local function sendSticker(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, sticker, cb, cmd)  
local input_message_content = {    ID = "InputMessageSticker",   sticker_ = getInputFile(sticker),    width_ = 0,    height_ = 0  } sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd) 
end
local function sendPhoto(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, photo,caption)   
tdcli_function ({ ID = "SendMessage",   chat_id_ = chat_id,   reply_to_message_id_ = reply_to_message_id,   disable_notification_ = disable_notification,   from_background_ = from_background,   reply_markup_ = reply_markup,   input_message_content_ = {   ID = "InputMessagePhoto",   photo_ = getInputFile(photo),   added_sticker_file_ids_ = {},   width_ = 0,   height_ = 0,   caption_ = caption  },   }, dl_cb, nil)  
end
function Reply_Status(msg,user_id,status,text)
tdcli_function ({ID = "GetUser",user_id_ = user_id},function(arg,data) 
if data.first_name_ ~= false then
local UserName = (data.username_ or "TuBakx")
local NameUser = "🚹꒐ بواًسطة : ["..data.first_name_.."](T.me/"..UserName..")"
local NameUserr = "🚹꒐ اسم المستخدم : ["..data.first_name_.."](T.me/"..UserName..")"
if status == "reply" then
send(msg.chat_id_, msg.id_,NameUserr.."\n"..text)
return false
end
else
send(msg.chat_id_, msg.id_,"⚠️| الحساب محذوف يرجى استخدام الامر بصوره صحيحه")
end
end,nil)   
end 
function Total_Msg(msgs)  
local TuBacK_Msg = ''  
if msgs < 100 then 
TuBacK_Msg = 'غير متفاعل' 
elseif msgs < 200 then 
TuBacK_Msg = 'بده يتحسن' 
elseif msgs < 400 then 
TuBacK_Msg = 'شبه متفاعل' 
elseif msgs < 700 then 
TuBacK_Msg = 'متفاعل' 
elseif msgs < 1200 then 
TuBacK_Msg = 'متفاعل قوي' 
elseif msgs < 2000 then 
TuBacK_Msg = 'متفاعل جدا' 
elseif msgs < 3500 then 
TuBacK_Msg = 'اقوى تفاعل'  
elseif msgs < 4000 then 
TuBacK_Msg = 'متفاعل نار' 
elseif msgs < 4500 then 
TuBacK_Msg = 'قمة التفاعل'
elseif msgs < 5500 then 
TuBacK_Msg = 'اقوى متفاعل' 
elseif msgs < 7000 then 
TuBacK_Msg = 'ملك التفاعل' 
elseif msgs < 9500 then 
TuBacK_Msg = 'عالي جدآ' 
elseif msgs < 10000000000 then 
TuBacK_Msg = 'قوي جدآ'  
end 
return TuBacK_Msg 
end
function Get_Info(msg,chat,user) 
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. chat ..'&user_id='.. user..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.status == "creator" then
Send(msg.chat_id_,msg.id_,'\n🚹| مالك المجموعة')   
return false  end 
if Json_Info.result.status == "member" then
Send(msg.chat_id_,msg.id_,'\n♿| مجرد عضو هنا ')   
return false  end
if Json_Info.result.status == 'left' then
Send(msg.chat_id_,msg.id_,'\n⚠️| الشخص غير موجود هنا ')   
return false  end
if Json_Info.result.status == "administrator" then
if Json_Info.result.can_change_info == true then
info = '✔️'
else
info = '✖'
end
if Json_Info.result.can_delete_messages == true then
delete = '✔️'
else
delete = '✖'
end
if Json_Info.result.can_invite_users == true then
invite = '✔️'
else
invite = '✖'
end
if Json_Info.result.can_pin_messages == true then
pin = '✔️'
else
pin = '✖'
end
if Json_Info.result.can_restrict_members == true then
restrict = '✔️'
else
restrict = '✖'
end
if Json_Info.result.can_promote_members == true then
promote = '✔️'
else
promote = '✖'
end
Send(chat,msg.id_,'\n- الرتبة : مشرف  '..'\n- والصلاحيات هي ↓ \nٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯'..'\n- تغير معلومات الكروب ‹- ❴ '..info..' ❵'..'\n- حذف الرسائل ‹- ❴ '..delete..' ❵'..'\n- حظر المستخدمين ‹- ❴ '..restrict..' ❵'..'\n- دعوة مستخدمين ‹- ❴ '..invite..' ❵'..'\n- تثبيت الرسائل ‹- ❴ '..pin..' ❵'..'\n- اضافة مشرفين جدد ‹- ❴ '..promote..' ❵')   
end
end
end
function GetFile_Bot(msg)
local list = database:smembers(bot_id..'Chek:Groups') 
local t = '{"BOT_ID": '..bot_id..',"GP_BOT":{'  
for k,v in pairs(list) do   
NAME = 'TuBacK Chat'
link = database:get(bot_id.."Private:Group:Link"..msg.chat_id_) or ''
ASAS = database:smembers(bot_id..'Basic:Constructor'..v)
MNSH = database:smembers(bot_id..'Constructor'..v)
MDER = database:smembers(bot_id..'Manager'..v)
MOD = database:smembers(bot_id..'Mod:User'..v)
if k == 1 then
t = t..'"'..v..'":{"TuBacK":"'..NAME..'",'
else
t = t..',"'..v..'":{"TuBacK":"'..NAME..'",'
end
if #ASAS ~= 0 then 
t = t..'"ASAS":['
for k,v in pairs(ASAS) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MOD ~= 0 then
t = t..'"MOD":['
for k,v in pairs(MOD) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MDER ~= 0 then
t = t..'"MDER":['
for k,v in pairs(MDER) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MNSH ~= 0 then
t = t..'"MNSH":['
for k,v in pairs(MNSH) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
t = t..'"linkgroup":"'..link..'"}' or ''
end
t = t..'}}'
local File = io.open('./'..bot_id..'.json', "w")
File:write(t)
File:close()
sendDocument(msg.chat_id_, msg.id_,0, 1, nil, './'..bot_id..'.json', '- عدد كروبات التي في البوت { '..#list..'}')
end
function download_to_file(url, file_path) 
local respbody = {} 
local options = { url = url, sink = ltn12.sink.table(respbody), redirect = true } 
local response = nil 
options.redirect = false 
response = {https.request(options)} 
local code = response[2] 
local headers = response[3] 
local status = response[4] 
if code ~= 200 then return false, code 
end 
file = io.open(file_path, "w+") 
file:write(table.concat(respbody)) 
file:close() 
return file_path, code 
end 
function Addjpg(msg,chat,ID_FILE,File_Name)
local File = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..ID_FILE)) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path,File_Name) 
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil,'./'..File_Name,'✅| تم تحويل الملصق الى صوره')     
os.execute('rm -rf ./'..File_Name) 
end
function Addvoi(msg,chat,vi,ty)
local eq = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..vi)) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..eq.result.file_path,ty) 
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil, './'..ty)   
os.execute('rm -rf ./'..ty) 
end
function Addmp3(msg,chat,kkl,ffrr)
local eer = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..kkl)) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..eer.result.file_path,ffrr) 
sendAudio(msg.chat_id_,msg.id_,'./'..ffrr,"- TeAM Source TuBaK.")  
os.execute('rm -rf ./'..ffrr) 
end
function Addsticker(msg,chat,Sd,rre)
local Qw = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..Sd)) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..Qw.result.file_path,rre) 
sendSticker(msg.chat_id_, msg.id_, 0, 1, nil, './'..rre)
os.execute('rm -rf ./'..rre) 
end
function AddFile_Bot(msg,chat,ID_FILE,File_Name)
if File_Name:match('.json') then
if tonumber(File_Name:match('(%d+)')) ~= tonumber(bot_id) then 
send(chat,msg.id_,"ℹ️| ملف نسخه ليس لهاذا البوت")
return false 
end      
local File = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..ID_FILE) ) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path, ''..File_Name) 
send(chat,msg.id_,"◀️| جاري ... رفع الملف الان")
else
send(chat,msg.id_,"⚠️| عذرا الملف ليس بصيغة {JSON} يرجى رفع الملف الصحيح*")
end      
local info_file = io.open('./'..bot_id..'.json', "r"):read('*a')
local groups = JSON.decode(info_file)
for idg,v in pairs(groups.GP_BOT) do
database:sadd(bot_id..'Chek:Groups',idg)  
database:set(bot_id..'lock:tagservrbot'..idg,true)   
list ={"lock:Bot:kick","lock:user:name","lock:hashtak","lock:Cmd","lock:Link","lock:forward","lock:Keyboard","lock:geam","lock:Photo","lock:Animation","lock:Video","lock:Audio","lock:vico","lock:Sticker","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:set(bot_id..lock..idg,'del')    
end
if v.MNSH then
for k,idmsh in pairs(v.MNSH) do
database:sadd(bot_id..'Constructor'..idg,idmsh)
end
end
if v.MDER then
for k,idmder in pairs(v.MDER) do
database:sadd(bot_id..'Manager'..idg,idmder)  
end
end
if v.MOD then
for k,idmod in pairs(v.MOD) do
database:sadd(bot_id..'Mod:User'..idg,idmod)  
end
end
if v.ASAS then
for k,idASAS in pairs(v.ASAS) do
database:sadd(bot_id..'Basic:Constructor'..idg,idASAS)  
end
end
end
send(chat,msg.id_,"☑️| تم رفع الملف بنجاح وتفعيل المجموعات\n🚹| ورفع -› ( الاساسين / المنشئين / المدراء / الادمنيه) بنجاح ✅")
end
local function trigger_anti_spam(msg,type)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)
local Name = '['..utf8.sub(data.first_name_,0,40)..'](tg://user?id='..data.id_..')'
if type == 'kick' then 
Text = '\n🚹| العضــو : '..Name..'\n🚯| قام بالتكرار هنا وتم طرده '  
sendText(msg.chat_id_,Text,0,'md')
chat_kick(msg.chat_id_,msg.sender_user_id_) 
my_ide = msg.sender_user_id_
msgm = msg.id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
return false  
end 
if type == 'del' then 
DeleteMessage(msg.chat_id_,{[0] = msg.id_})    
my_ide = msg.sender_user_id_
msgm = msg.id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
end 
if type == 'keed' then
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" ..msg.chat_id_.. "&user_id=" ..msg.sender_user_id_.."") 
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_) 
msgm = msg.id_
my_ide = msg.sender_user_id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
Text = '\n🚹| العضــو : '..Name..'\n🚷| قام بالتكرار هنا وتم تقييده '  
sendText(msg.chat_id_,Text,0,'md')
return false  
end  
if type == 'mute' then
Text = '\n🚹| العضــو : '..Name..'\n🚫| قام بالتكرار هنا وتم كتمه '  
sendText(msg.chat_id_,Text,0,'md')
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_) 
msgm = msg.id_
my_ide = msg.sender_user_id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
return false  
end
end,nil)   
end  
function plugin_TuBacK(msg)
for v in io.popen('ls File_Bot'):lines() do
if v:match(".lua$") then
plugin = dofile("File_Bot/"..v)
if plugin.TuBacK and msg then
pre_msg = plugin.TuBacK(msg)
end
end
end
send(msg.chat_id_, msg.id_,pre_msg)  
end

function SourceTuBacK(msg,data)
if msg then
local text = msg.content_.text_

if msg.chat_id_ then
local id = tostring(msg.chat_id_)
if id:match("-100(%d+)") then
database:incr(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) 
Chat_Type = 'GroupBot' 
elseif id:match("^(%d+)") then
database:sadd(bot_id..'User_Bot',msg.sender_user_id_)  
Chat_Type = 'UserBot' 
else
Chat_Type = 'GroupBot' 
end
end
if database:get(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == "الغاء" or text == "الغاء ✖️" then   
send(msg.chat_id_, msg.id_,"❎| تم الغاء الاذاعه")
database:del(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = database:smembers(bot_id.."Chek:Groups") 
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,"["..msg.content_.text_.."]")  
database:set(bot_id..'Msg:Pin:Chat'..v,msg.content_.text_) 
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, photo,(msg.content_.caption_ or ""))
database:set(bot_id..'Msg:Pin:Chat'..v,photo) 
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or "")) 
database:set(bot_id..'Msg:Pin:Chat'..v,msg.content_.animation_.animation_.persistent_id_)
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, msg.content_.sticker_.sticker_.persistent_id_)   
database:set(bot_id..'Msg:Pin:Chat'..v,msg.content_.sticker_.sticker_.persistent_id_) 
end 
end
send(msg.chat_id_, msg.id_,"✅| تمت الاذاعه الى *~ "..#list.." ~* مجموعة 👥 ")
database:del(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end
if text == "رابط حذف" or text == "رابط الحذف" or text == "اريد رابط الحذف" or  text == "شمرلي رابط الحذف" or text == "اريد رابط حذف" then 
local url,res = https.request('https://anashtick.ml/TuBak.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.TuBak ~= true then
local inline = {{{text="اضغط هنا للشتراك 🚹",url="https://t.me/TuBakx"}}}
SendInline(msg.chat_id_,'عذراً عليك الاشتراك في [. Team TuBak](t.me/TuBaKx) \nليمكنك استخدام البوت بشكل كامل',nil,inline)
return false 
end
local inline = {{{text="رابط الحذف",url="https://my.telegram.org/auth?to=delete"}}} 
SendInline(msg.chat_id_,'رابط حذف حساب التلكرام 🔽',nil,inline) return false end
--------------------------------------------------------------------------------------------------------------
if text == 'قسم الاذاعة 📨' then 
if DevTuBacK(msg) then
local bl = '👋🏻꒐ أهلاً بك ، [المطور الاساسي .](t.me/Tubakx)\n🔽꒐ اليك قسم الكيبورد للاذاعة '
local keyboard = {
{'اذاعه بالتثبيت 📥'},
{'اذاعه عام 🚻','اذاعه خاص 📨'},
{'اذاعه بالتوجيه 📩','توجيه خاص 🗳️'},
{'رجوع 🔝'},
}
send_inline_key(msg.chat_id_,bl,keyboard)
return false  
end 
end
if text == 'قسم الاشتراك ⚖️' then 
if DevTuBacK(msg) then
local bl = '👋🏻꒐ أهلاً بك ، [المطور الاساسي .](t.me/Tubakx)\n🔽꒐ اليك قسم الكيبورد للاشتراك الاجباري '
local keyboard = {
{'تفعيل الاشتراك 🔔','تفعيل الاشتراك 🚫'},
{'تغير الاشتراك 🏷️'},
{'الاشتراك الاجباري 💈','وضع قناة الاشتراك ➗'},
{'تغير رساله الاشتراك 🗞️','حذف رساله الاشتراك 🚸'},
{'رجوع 🔝'},
}
send_inline_key(msg.chat_id_,bl,keyboard)
return false  
end 
end
if Chat_Type == 'UserBot' then
if text == '/start' or text == 'رجوع 🔝' then   
local url,res = https.request('https://anashtick.ml/TuBak.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.TuBak ~= true then
local inline = {{{text="اضغط هنا للشتراك 🚹",url="https://t.me/TuBakx"}}}
SendInline(msg.chat_id_,'عذراً عليك الاشتراك في [. Team TuBak](t.me/TuBaKx) \nليمكنك استخدام البوت بشكل كامل',nil,inline)
return false 
end
if DevTuBacK(msg) then
local bl = '👋🏻꒐ أهلاً بك ، [المطور الاساسي ](t.me/Tubakx)\n🔽꒐ يمكنك استخدام الاوامر التي ظهرت لك'
local keyboard = {
{'تغير اسم البوت 🔁'},
{'تعطيل التواصل 🔰','تفعيل التواصل ⚡'},
{'الاحصائيات 📈'},
{'قسم الاذاعة 📨','قسم الاشتراك ⚖️'},
{'المطورين 🛡️','قائمه العام 🚯'},
{'مسح الاساسيين 🚮','الاساسيين 🚹'},
{'ضع كليشة ستارت ⌨️','حذف الستارت 📧'},
{'تفعيل البوت الخدمي 🔖','تعطيل البوت الخدمي 📛'},
{'تنظيف المجموعات 📊','تنظيف المشتركين ℹ️'},
{'جلب نسخه الاحتياطيه 🗂️'},
{'تحديث السورس ✅','الاصدار 📃'},
{'معلومات السيرفر 🗃️'},
{'الغاء ✖️'},
}
send_inline_key(msg.chat_id_,bl,keyboard)
else
if not database:get(bot_id..'Start:Time'..msg.sender_user_id_) then
local start = database:get(bot_id.."Start:Bot")  
if start then 
Text = start
else
Text = '👋🏻꒐ اهلا بك في بوت حماية المجموعات\n⏺꒐ يمكنك اضافتي الى مجموعتك [وتفعيلي .](t.me/tubakx)\n⎯ ⎯ ⎯ ⎯'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'TeamTuBak',url="t.me/TubAkx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
end
database:setex(bot_id..'Start:Time'..msg.sender_user_id_,300,true)
return false
end
if not DevTuBacK(msg) and not database:sismember(bot_id..'Ban:User_Bot',msg.sender_user_id_) and not database:get(bot_id..'Tuasl:Bots') then
send(msg.sender_user_id_, msg.id_,'✅| تم ارسال رسالتك الي *المطور*\n⏰| سيتم رد في اقرب وقت')
tdcli_function ({ID = "ForwardMessages", chat_id_ = SUDO,    from_chat_id_ = msg.sender_user_id_,    message_ids_ = {[0] = msg.id_},    disable_notification_ = 1,    from_background_ = 1 },function(arg,data) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,ta) 
vardump(data)
if data and data.messages_[0].content_.sticker_ then
local Name = '['..string.sub(ta.first_name_,0, 40)..'](tg://user?id='..ta.id_..')'
local Text = '◀️| م ارسال الملصق من ↓\n - '..Name
sendText(SUDO,Text,0,'md')
end 
end,nil) 
end,nil)
end
if DevTuBacK(msg) and msg.reply_to_message_id_ ~= 0  then    
tdcli_function({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)},function(extra, result, success) 
if result.forward_info_.sender_user_id_ then     
id_user = result.forward_info_.sender_user_id_    
end     
tdcli_function ({ID = "GetUser",user_id_ = id_user},function(arg,data) 
if text == 'حظر' then
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '🚹| المستخدم : '..Name..'\n🚷| تم حظره من المجموعة من التواصل'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
database:sadd(bot_id..'Ban:User_Bot',data.id_)  
return false  
end 
if text =='الغاء الحظر' then
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '🚹| المستخدم : '..Name..'\n🚷| تم الغاء حظره من المجموعة من التواصل'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
database:srem(bot_id..'Ban:User_Bot',data.id_)  
return false  
end 

tdcli_function({ID='GetChat',chat_id_ = id_user},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",chat_id_ = id_user, action_ = {  ID = "SendMessageTypingAction", progress_ = 100} },function(arg,ta) 
if ta.code_ == 400 or ta.code_ == 5 then
local TuBacK_Msg = '\n🚫| قام الشخص بحظر البوت'
send(msg.chat_id_, msg.id_,TuBacK_Msg) 
return false  
end 
if text then    
send(id_user,msg.id_,text)    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '🚹| المستخدم : '..Name..'\n💭| تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end    
if msg.content_.ID == 'MessageSticker' then    
sendSticker(id_user, msg.id_, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '🚹| المستخدم : '..Name..'\n💭| تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end      
if msg.content_.ID == 'MessagePhoto' then    
sendPhoto(id_user, msg.id_, 0, 1, nil,msg.content_.photo_.sizes_[0].photo_.persistent_id_,(msg.content_.caption_ or ''))    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '🚹| المستخدم : '..Name..'\n💭| تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end     
if msg.content_.ID == 'MessageAnimation' then    
sendDocument(id_user, msg.id_, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_)    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '🚹| المستخدم : '..Name..'\n💭| تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end     
if msg.content_.ID == 'MessageVoice' then    
sendVoice(id_user, msg.id_, 0, 1, nil, msg.content_.voice_.voice_.persistent_id_)    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '🚹| المستخدم : '..Name..'\n💭| تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end     
end,nil)
end,nil)
end,nil)
end,nil)
end 
if text == 'تفعيل التواصل ⚡' and DevTuBacK(msg) then  
if database:get(bot_id..'Tuasl:Bots') then
database:del(bot_id..'Tuasl:Bots') 
Text = '\n✅| تم تفعيل التواصل ' 
else
Text = '\n☑️| بالتاكيد تم تفعيل التواصل '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل التواصل 🔰' and DevTuBacK(msg) then  
if not database:get(bot_id..'Tuasl:Bots') then
database:set(bot_id..'Tuasl:Bots',true) 
Text = '\n❎| تم تعطيل التواصل' 
else
Text = '\n❎| بالتاكيد تم تعطيل التواصل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل البوت الخدمي 🔖' and DevTuBacK(msg) then  
if database:get(bot_id..'Free:Bots') then
database:del(bot_id..'Free:Bots') 
Text = '\n✅| تم تفعيل البوت الخدمي ' 
else
Text = '\n☑️| بالتاكيد تم تفعيل البوت الخدمي '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل البوت الخدمي 📛' and DevTuBacK(msg) then  
if not database:get(bot_id..'Free:Bots') then
database:set(bot_id..'Free:Bots',true) 
Text = '\n❎| تم تعطيل البوت الخدمي' 
else
Text = '\n❎| بالتاكيد تم تعطيل البوت الخدمي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text and database:get(bot_id..'Start:Bots') then
if text == 'الغاء' or text == 'الغاء ✖️' then   
send(msg.chat_id_, msg.id_,'❎| الغاء حفظ كليشه ستارت')
database:del(bot_id..'Start:Bots') 
return false
end
database:set(bot_id.."Start:Bot",text)  
send(msg.chat_id_, msg.id_,'☑️| تم حفظ كليشه ستارت')
database:del(bot_id..'Start:Bots') 
return false
end
if text == 'ضع كليشة ستارت ⌨️' and DevTuBacK(msg) then 
database:set(bot_id..'Start:Bots',true) 
send(msg.chat_id_, msg.id_,'↪️| ارسل لي الكليشه الان')
return false
end
if text == 'حذف الستارت 📧' and DevTuBacK(msg) then 
database:del(bot_id..'Start:Bot') 
send(msg.chat_id_, msg.id_,'🚮| تم حذف كليشه ستارت')
end
if text == 'معلومات السيرفر 🗃️' and DevTuBacK(msg) then 
send(msg.chat_id_, msg.id_, io.popen([[
linux_version=`lsb_release -ds`
memUsedPrc=`free -m | awk 'NR==2{printf "%sMB/%sMB {%.2f%}\n", $3,$2,$3*100/$2 }'`
HardDisk=`df -lh | awk '{if ($6 == "/") { print $3"/"$2" ~ {"$5"}" }}'`
CPUPer=`top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}'`
uptime=`uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes."}'`
echo '⇗ نظام التشغيل ⇖•\n*-›-› '"$linux_version"'*' 
echo '*———————————~*\n{ الذاكره العشوائيه } ⇎\n*-›-› '"$memUsedPrc"'*'
echo '*———————————~*\n{ وحـده الـتـخـزيـن } ⇎\n*-›-› '"$HardDisk"'*'
echo '*———————————~*\n{ الـمــعــالــج } ⇎\n*-›-› '"`grep -c processor /proc/cpuinfo`""Core ~ {$CPUPer%} "'*'
echo '*———————————~*\n{ الــدخــول } ⇎\n*-›-› '`whoami`'*'
echo '*———————————~*\n{ مـده تـشغيـل الـسـيـرفـر }⇎\n*-›-› '"$uptime"'*'
]]):read('*all'))  
end

if text == 'تحديث السورس ✅' and DevTuBacK(msg) then 
os.execute('rm -rf TuBacK.lua')
os.execute('https://raw.githubusercontent.com/Tubaktele/TuBacK/main/TuBacK.lua')
send(msg.chat_id_, msg.id_,'☑️| تم تحديث السورس \n◀️| لديك اخر اصدار لسورس توباك\n🛡️| اصدار السورس -› (* v1.0*)')
dofile('TuBacK.lua')  
end
if text == 'الاصدار 📃' and DevTuBacK(msg) then 
database:del(bot_id..'Srt:Bot') 
send(msg.chat_id_, msg.id_,'◀️| اصدار سورس توباك لديك (*v1.0*) 🛡️')
end
if text == "تغير اسم البوت 🔁" and DevTuBacK(msg) then  
database:setex(bot_id..'Set:Name:Bot'..msg.sender_user_id_,300,true) 
send(msg.chat_id_, msg.id_,"↪️| حسناً ارسل اسم البوت")
return false
end
if text == 'الاحصائيات 📈' and DevTuBacK(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = '📊꒐* احصائيات البوت :*\n\n🚻꒐ عدد المجموعات :* '..Groups..'*\n🚹꒐ عدد المحادثات :* '..Users..'*'
send(msg.chat_id_, msg.id_,Text) 
return false
end
if text == ("المطورين 🛡️") and DevTuBacK(msg) then
local list = database:smembers(bot_id..'Sudo:User')
t = "\n📋| قائمة المطورين \nٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- ("..v..")\n"
end
end
if #list == 0 then
t = "⚠️| لا يوجد مطورين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("الاساسيين 🚹") and DevTuBacK(msg) then
local list = database:smembers(bot_id.."Dev:AhMd:2")
t = "\n📋| قائمة مطورين الاساسيين للبوت \nٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "⚠️| لا يوجد مطورين ثانويين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("مسح الاساسيين 🚮") and DevTuBacK(msg) then
database:del(bot_id.."Dev:AhMd:2")
send(msg.chat_id_, msg.id_, "\n✅| تم مسح قائمة المطورين الاساسيين  ")
end
if text == ("قائمه العام 🚯") and DevTuBacK(msg) then
local list = database:smembers(bot_id..'GBan:User')
t = "\n📋| قائمه المحظورين عام \nٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- ("..v..")\n"
end
end
if #list == 0 then
t = "⚠️| لا يوجد محظورين عام"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text=="اذاعه خاص 📨" and msg.reply_to_message_id_ == 0 and DevTuBacK(msg) then 
database:setex(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ↪️| ارسل الان اذاعتك؟ \n📌| للخروج ارسل الغاء ")
return false
end 
if text=="اذاعه عام 🚻" and msg.reply_to_message_id_ == 0 and DevTuBacK(msg) then 
database:setex(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ↪️| ارسل الان اذاعتك؟ \n📌| للخروج ارسل الغاء ")
return false
end  
if text=="اذاعه بالتثبيت 📥" and msg.reply_to_message_id_ == 0 and DevTuBacK(msg) then 
database:setex(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ↪️| ارسل الان اذاعتك؟ \n📌| للخروج ارسل الغاء ")
return false
end 
if text=="اذاعه بالتوجيه 📩" and msg.reply_to_message_id_ == 0  and DevTuBacK(msg) then 
database:setex(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"↪️| ارسل لي التوجيه الان")
return false
end 
if text=="توجيه خاص 🗳️" and msg.reply_to_message_id_ == 0  and DevTuBacK(msg) then 
database:setex(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"↪️| ارسل لي التوجيه الان")
return false
end 
if text == 'جلب نسخه الاحتياطيه 🗂️' and DevTuBacK(msg) then 
GetFile_Bot(msg)
end
if text == "تنظيف المشتركين ℹ️" and DevTuBacK(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local pv = database:smembers(bot_id.."User_Bot")
local sendok = 0
for i = 1, #pv do
tdcli_function({ID='GetChat',chat_id_ = pv[i]
},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",  
chat_id_ = pv[i], action_ = {  ID = "SendMessageTypingAction", progress_ = 100} 
},function(arg,data) 
if data.ID and data.ID == "Ok"  then
else
database:srem(bot_id.."User_Bot",pv[i])
sendok = sendok + 1
end
if #pv == i then 
if sendok == 0 then
send(msg.chat_id_, msg.id_,'ℹ️| لا يوجد مشتركين وهميين في البوت \n')   
else
local ok = #pv - sendok
send(msg.chat_id_, msg.id_,'🚹| عدد المشتركين الان -› ( '..#pv..' )\n🗑️|تم حذف -› ( '..sendok..' ) من المشتركين\n◀️| عدد المشتركين الحقيقي الان -› ( '..ok..' ) مشترك 🗣️\n')
end
end
end,nil)
end,nil)
end
return false
end
if text == "تنظيف المجموعات 📊" and DevTuBacK(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local group = database:smembers(bot_id..'Chek:Groups') 
local w = 0
local q = 0
for i = 1, #group do
tdcli_function({ID='GetChat',chat_id_ = group[i]
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
database:srem(bot_id..'Chek:Groups',group[i])  
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=group[i],user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
w = w + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.code_ and data.code_ == 400 then
database:srem(bot_id..'Chek:Groups',group[i])  
w = w + 1
end
if #group == i then 
if (w + q) == 0 then
send(msg.chat_id_, msg.id_,'ℹ️| لا يوجد كروبات وهميه في البوت\n')   
else
local TuBacK = (w + q)
local sendok = #group - TuBacK
if q == 0 then
TuBacK = ''
else
TuBacK = '\n🚮| تم ازالة -› { '..q..' } مجموعة من البوت'
end
if w == 0 then
TuBacKk = ''
else
TuBacKk = '\n🚮| تم ازالة -› {'..w..'} مجموعة لان البوت عضو'
end
send(msg.chat_id_, msg.id_,'📊| عدد المجموعات الان -› { '..#group..' }'..TuBacKk..''..TuBacK..'\n🔢| عدد المجموعات الحقيقي -› { '..sendok..' } مجموعة\n')   
end
end
end,nil)
end
return false
end


if text and text:match("^رفع مطور @(.*)$") and DevTuBacK(msg) then
local username = text:match("^رفع مطور @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")
return false 
end      
database:sadd(bot_id..'Sudo:User', result.id_)
usertext = '\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(username or 'TuBakx')..')'
status  = '\n⏫| تم ترقيته مطور'
texts = usertext..status
else
texts = '⚠️| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false 
end
if text and text:match("^رفع مطور (%d+)$") and DevTuBacK(msg) then
local userid = text:match("^رفع مطور (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n⏫| تم ترقيته مطور'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n🚹꒐ العضو :  '..userid..''
status  = '\n⏫| تم ترقيته مطور'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text and text:match("^تنزيل مطور @(.*)$") and DevTuBacK(msg) then
local username = text:match("^تنزيل مطور @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Sudo:User', result.id_)
usertext = '\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(username or 'TuBakx')..')'
status  = '\n⏬| تم تنزيله من المطورين'
texts = usertext..status
else
texts = '⚠️| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مطور (%d+)$") and DevTuBacK(msg) then
local userid = text:match("^تنزيل مطور (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n⏬| تم تنزيله من المطورين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n🚹꒐ العضو :  '..userid..''
status  = '\n⏬| تم تنزيله من المطورين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end

end
--------------------------------------------------------------------------------------------------------------
if text and not Special(msg) then  
local TuBacK1_Msg = database:get(bot_id.."TuBacK1:Add:Filter:Rp2"..text..msg.chat_id_)   
if TuBacK1_Msg then 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'🚹꒐ العضو :  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n▶️| '..TuBacK1_Msg)
DeleteMessage(msg.chat_id_, {[0] = msg.id_})     
return false
end,nil)
end
end
if database:get(bot_id..'Set:Name:Bot'..msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ✖️' then   
send(msg.chat_id_, msg.id_,"❎| تم الغاء حفظ اسم البوت")
database:del(bot_id..'Set:Name:Bot'..msg.sender_user_id_) 
return false  
end 
database:del(bot_id..'Set:Name:Bot'..msg.sender_user_id_) 
database:set(bot_id..'Name:Bot',text) 
send(msg.chat_id_, msg.id_, "☑️| تم حفظ اسم البوت")
return false
end 
if database:get(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ✖️' then   
send(msg.chat_id_, msg.id_,"❎| تم الغاء الاذاعه للخاص")
database:del(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = database:smembers(bot_id..'User_Bot') 
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,'['..msg.content_.text_..']')  
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, 0, 1, nil, photo,(msg.content_.caption_ or ''))
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ''))    
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
end 
end
send(msg.chat_id_, msg.id_,"🚻| تمت الاذاعه الى -› {"..#list.."} مشترك في البوت ")
database:del(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end

if database:get(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ✖️' then   
send(msg.chat_id_, msg.id_,"❎| تم الغاء الاذاعه")
database:del(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = database:smembers(bot_id..'Chek:Groups') 
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,'['..msg.content_.text_..']')  
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, 0, 1, nil, photo,(msg.content_.caption_ or ''))
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ''))    
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
end 
end
send(msg.chat_id_, msg.id_,"📊| تمت الاذاعه الى -› {"..#list.."} مجموعة في البوت ")
database:del(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end

if database:get(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ✖️' then   
send(msg.chat_id_, msg.id_,"❎| تم الغاء الاذاعه")
database:del(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false  
end 
if msg.forward_info_ then 
local list = database:smembers(bot_id..'Chek:Groups')   
for k,v in pairs(list) do  
tdcli_function({ID="ForwardMessages",
chat_id_ = v,
from_chat_id_ = msg.chat_id_,
message_ids_ = {[0] = msg.id_},
disable_notification_ = 0,
from_background_ = 1},function(a,t) end,nil) 
end   
send(msg.chat_id_, msg.id_,"📊| تمت الاذاعه الى -› {"..#list.."} مجموعة في البوت ")
database:del(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end 
end
if database:get(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ✖️' then   
send(msg.chat_id_, msg.id_,"❎| تم الغاء الاذاعه")
database:del(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false  
end 
if msg.forward_info_ then 
local list = database:smembers(bot_id..'User_Bot')   
for k,v in pairs(list) do  
tdcli_function({ID="ForwardMessages",
chat_id_ = v,
from_chat_id_ = msg.chat_id_,
message_ids_ = {[0] = msg.id_},
disable_notification_ = 0,
from_background_ = 1},function(a,t) end,nil) 
end   
send(msg.chat_id_, msg.id_,"🚻| تمت الاذاعه الى -› {"..#list.."} مشترك في البوت ")
database:del(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end 
end
if database:get(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_, "✅| تم الغاء الامر ")
database:del(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  end 
database:del(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local username = string.match(text, "@[%a%d_]+") 
tdcli_function ({    
ID = "SearchPublicChat",    
username_ = username  
},function(arg,data) 
if data and data.message_ and data.message_ == "USERNAME_NOT_OCCUPIED" then 
send(msg.chat_id_, msg.id_, '⚠️| المعرف لا يوجد فيه قناة')
return false  end
if data and data.type_ and data.type_.ID and data.type_.ID == 'PrivateChatInfo' then
send(msg.chat_id_, msg.id_, 'ℹ️| عذا لا يمكنك وضع معرف حسابات في الاشتراك ')
return false  end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.is_supergroup_ == true then
send(msg.chat_id_, msg.id_,'ℹ️| عذا لا يمكنك وضع معرف المجموعة بالاشتراك ')
return false  end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.is_supergroup_ == false then
if data and data.type_ and data.type_.channel_ and data.type_.channel_.ID and data.type_.channel_.status_.ID == 'ChatMemberStatusEditor' then
send(msg.chat_id_, msg.id_,'📌| البوت ادمن في القناة \n☑️| تم تفعيل الاشتراك الاجباري في \n🏷️| ايدي القناة ('..data.id_..')\n▶️| معرف القناة ([@'..data.type_.channel_.username_..'])')
database:set(bot_id..'add:ch:id',data.id_)
database:set(bot_id..'add:ch:username','@'..data.type_.channel_.username_)
else
send(msg.chat_id_, msg.id_,'ℹ️| عذرآ البوت ليس ادمن بالقناه ')
end
return false  
end
end,nil)
end
if database:get(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_, "✅| تم الغاء الامر ")
database:del(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  end 
database:del(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local texxt = string.match(text, "(.*)") 
database:set(bot_id..'text:ch:user',texxt)
send(msg.chat_id_, msg.id_,'✅| تم تغيير رسالة الاشتراك ')
end

local status_welcome = database:get(bot_id..'Chek:Welcome'..msg.chat_id_)
if status_welcome and not database:get(bot_id..'lock:tagservr'..msg.chat_id_) then
if msg.content_.ID == "MessageChatJoinByLink" then
tdcli_function({ID = "GetUser",user_id_=msg.sender_user_id_},function(extra,result) 
local GetWelcomeGroup = database:get(bot_id..'Get:Welcome:Group'..msg.chat_id_)  
if GetWelcomeGroup then 
t = GetWelcomeGroup
else  
t = '\n• نورت يقميل 💘. \n•  name \n• user' 
end 
t = t:gsub('name',result.first_name_) 
t = t:gsub('user',('@'..result.username_ or 'لا يوجد')) 
send(msg.chat_id_, msg.id_,'['..t..']')
end,nil) 
end 
end 
--------------------------------------------------------------------------------------------------------------
if msg.content_.photo_ then  
if database:get(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) then 
if msg.content_.photo_.sizes_[3] then  
photo_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_ 
else 
photo_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_ 
end 
tdcli_function ({ID = "ChangeChatPhoto",chat_id_ = msg.chat_id_,photo_ = getInputFile(photo_id) }, function(arg,data)   
if data.code_ == 3 then
send(msg.chat_id_, msg.id_,'ℹ️| عذرآ البوت ليس ادمن بالقناه ')
database:del(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) 
return false  end
if data.message_ == "CHAT_ADMIN_REQUIRED" then 
send(msg.chat_id_, msg.id_,'ℹ️| … عذرآ البوت لايملك صلاحيات')
database:del(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) 
else
send(msg.chat_id_, msg.id_,'✅| تم تغيير صورة المجموعة')
end
end, nil) 
database:del(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) 
end   
end
--------------------------------------------------------------------------------------------------------------
if database:get(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then  
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_,"❎| تم الغاء وضع الوصف")
database:del(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_)
return false  
end 
database:del(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
https.request('https://api.telegram.org/bot'..token..'/setChatDescription?chat_id='..msg.chat_id_..'&description='..text) 
send(msg.chat_id_, msg.id_,'✅| تم تغيير وصف المجموعة')
return false  
end 
--------------------------------------------------------------------------------------------------------------
if database:get(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_,"❎| تم الغاء حفظ الترحيب")
database:del(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
database:del(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
database:set(bot_id..'Get:Welcome:Group'..msg.chat_id_,text) 
send(msg.chat_id_, msg.id_,'✅| تم حفظ ترحيب المجموعة')
return false   
end
--------------------------------------------------------------------------------------------------------------
if database:get(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_) then
if text == 'الغاء' then
send(msg.chat_id_,msg.id_,"❎| تم الغاء حفظ الرابط")
database:del(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_) 
return false
end
if text and text:match("(https://telegram.me/joinchat/%S+)") or text and text:match("(https://t.me/joinchat/%S+)") then     
local Link = text:match("(https://telegram.me/joinchat/%S+)") or text and text:match("(https://t.me/joinchat/%S+)")   
database:set(bot_id.."Private:Group:Link"..msg.chat_id_,Link)
send(msg.chat_id_,msg.id_,"✅| تم حفظ الرابط بنجاح")
database:del(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_) 
return false 
end
end 
--------------------------------------------------------------------------------------------------------------
if TuBacK_Msg and not Special(msg) then  
local TuBacK_Msg = database:get(bot_id.."Add:Filter:Rp2"..text..msg.chat_id_)   
if TuBacK_Msg then    
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0,"🚹| العضو : {["..data.first_name_.."](T.ME/"..data.username_..")}\n▶️| ["..TuBacK_Msg.."] \n")
else
send(msg.chat_id_,0,"🚹| العضو : {["..data.first_name_.."](T.ME/TuBakx)}\n▶️| ["..TuBacK_Msg.."] \n")
end
end,nil)   
DeleteMessage(msg.chat_id_, {[0] = msg.id_})     
return false
end
end
--------------------------------------------------------------------------------------------------------------
if not Special(msg) and msg.content_.ID ~= "MessageChatAddMembers" and database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") then 
floods = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") or 'nil'
NUM_MSG_MAX = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") or 5
TIME_CHECK = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") or 5
local post_count = tonumber(database:get(bot_id..'floodc:'..msg.sender_user_id_..':'..msg.chat_id_) or 0)
if post_count > tonumber(database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") or 5) then 
local ch = msg.chat_id_
local type = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") 
trigger_anti_spam(msg,type)  
end
database:setex(bot_id..'floodc:'..msg.sender_user_id_..':'..msg.chat_id_, tonumber(database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") or 3), post_count+1) 
local edit_id = data.text_ or 'nil'  
NUM_MSG_MAX = 5
if database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") then
NUM_MSG_MAX = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") 
end
if database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") then
TIME_CHECK = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") 
end 
end 
--------------------------------------------------------------------------------------------------------------
if text and database:get(bot_id..'lock:Fshar'..msg.chat_id_) and not Special(msg) then 
list = {"كس","كسمك","كسختك","عير","كسخالتك","خرا بالله","عير بالله","كسخواتكم","كحاب","مناويج","مناويج","كحبه","ابن الكحبه","فرخ","فروخ","طيزك","طيزختك"}
for k,v in pairs(list) do
print(string.find(text,v))
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
if text and database:get(bot_id..'lock:Fars'..msg.chat_id_) and not Special(msg) then 
list = {"ڄ","گ","که","پی","خسته","برم","راحتی","بیام","بپوشم","گرمه","چه","چ","ڬ","ٺ","چ","ڇ","ڿ","ڀ","ڎ","ݫ","ژ","ڟ","ݜ","ڸ","پ","۴","زدن","دخترا","دیوث","مک","زدن", "خالی بند","عزیزم خوبی","سلامت باشی","میخوام","سلام","خوببی","ميدم","کی اومدی","خوابیدین"}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
if text and database:get(bot_id..'lock:Engilsh'..msg.chat_id_) and not Special(msg) then 
list = {'a','u','y','l','t','b','A','Q','U','J','K','L','B','D','L','V','Z','k','n','c','r','q','o','z','I','j','m','M','w','d','h','e'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
--------------------------------------------------------------------------------------------------------------
if database:get(bot_id..'lock:text'..msg.chat_id_) and not Special(msg) then       
DeleteMessage(msg.chat_id_,{[0] = msg.id_})   
return false     
end     
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatAddMembers" then 
database:incr(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_) 
end
if msg.content_.ID == "MessageChatAddMembers" and not Special(msg) then   
if database:get(bot_id.."lock:AddMempar"..msg.chat_id_) == 'kick' then
local mem_id = msg.content_.members_  
for i=0,#mem_id do  
chat_kick(msg.chat_id_,mem_id[i].id_)
end
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatJoinByLink" and not Special(msg) then 
if database:get(bot_id.."lock:Join"..msg.chat_id_) == 'kick' then
chat_kick(msg.chat_id_,msg.sender_user_id_)
return false  
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("@[%a%d_]+") or msg.content_.caption_:match("@(.+)") then  
if database:get(bot_id.."lock:user:name"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("@[%a%d_]+") or text and text:match("@(.+)") then    
if database:get(bot_id.."lock:user:name"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("#[%a%d_]+") or msg.content_.caption_:match("#(.+)") then 
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("#[%a%d_]+") or text and text:match("#(.+)") then
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("/[%a%d_]+") or msg.content_.caption_:match("/(.+)") then  
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("/[%a%d_]+") or text and text:match("/(.+)") then
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if not Special(msg) then 
if msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") or msg.content_.caption_:match("[Ww][Ww][Ww].") or msg.content_.caption_:match(".[Cc][Oo][Mm]") or msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or msg.content_.caption_:match(".[Pp][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or msg.content_.caption_:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]/") or msg.content_.caption_:match("[Tt].[Mm][Ee]/") then 
if database:get(bot_id.."lock:Link"..msg.chat_id_) == "del" and not Special(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ked" and not Special(msg) then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "kick" and not Special(msg) then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ktm" and not Special(msg) then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or text and text:match("[Hh][Tt][Tt][Pp][Ss]://") or text and text:match("[Hh][Tt][Tt][Pp]://") or text and text:match("[Ww][Ww][Ww].") or text and text:match(".[Cc][Oo][Mm]") or text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or text and text:match(".[Pp][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or text and text:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]/") or text and text:match("[Tt].[Mm][Ee]/") and not Special(msg) then
if database:get(bot_id.."lock:Link"..msg.chat_id_) == "del" and not Special(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ked" and not Special(msg) then 
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "kick" and not Special(msg) then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ktm" and not Special(msg) then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessagePhoto' and not Special(msg) then     
if database:get(bot_id.."lock:Photo"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageVideo' and not Special(msg) then     
if database:get(bot_id.."lock:Video"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageAnimation' and not Special(msg) then     
if database:get(bot_id.."lock:Animation"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.game_ and not Special(msg) then     
if database:get(bot_id.."lock:geam"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageAudio' and not Special(msg) then     
if database:get(bot_id.."lock:Audio"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Audio"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Audio"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Audio"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageVoice' and not Special(msg) then     
if database:get(bot_id.."lock:vico"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.reply_markup_ and msg.reply_markup_.ID == 'ReplyMarkupInlineKeyboard' and not Special(msg) then     
if database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageSticker' and not Special(msg) then     
if database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
if tonumber(msg.via_bot_user_id_) ~= 0 and not Special(msg) then
if database:get(bot_id.."lock:inline"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:inline"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:inline"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:inline"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.forward_info_ and not Special(msg) then     
if database:get(bot_id.."lock:forward"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageDocument' and not Special(msg) then     
if database:get(bot_id.."lock:Document"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageUnsupported" and not Special(msg) then      
if database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.entities_ then 
if msg.content_.entities_[0] then 
if msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityUrl" or msg.content_.entities_[0].ID == "MessageEntityTextUrl" then      
if not Special(msg) then
if database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end  
end 
end
end 
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageContact' and not Special(msg) then      
if database:get(bot_id.."lock:Contact"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.text_ and not Special(msg) then  
local _nl, ctrl_ = string.gsub(text, '%c', '')  
local _nl, real_ = string.gsub(text, '%d', '')   
sens = 400  
if database:get(bot_id.."lock:Spam"..msg.chat_id_) == "del" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ked" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "kick" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ktm" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
if msg.content_.ID == 'MessageSticker' and not Manager(msg) then 
local filter = database:smembers(bot_id.."filtersteckr"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.sticker_.set_id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, "🚹| العضـو -› {[@"..data.username_.."]}\n⛔| عذرا تم منع الملصق \n" ) 
else
send(msg.chat_id_,0, "🚹| العضـو -› {["..data.first_name_.."](T.ME/TuBakx)}\n⛔| عذرا تم منع الملصق \n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end

------------------------------------------------------------------------

------------------------------------------------------------------------
if msg.content_.ID == 'MessagePhoto' and not Manager(msg) then 
local filter = database:smembers(bot_id.."filterphoto"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.photo_.id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0,"🚹| العضـو -› {[@"..data.username_.."]}\n🚫| عذرا تم منع الصوره \n" ) 
else
send(msg.chat_id_,0,"🚹| العضـو -› {["..data.first_name_.."](T.ME/TuBakx)}\n🚫| عذرا تم منع الصوره \n") 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end
------------------------------------------------------------------------
if msg.content_.ID == 'MessageAnimation' and not Manager(msg) then 
local filter = database:smembers(bot_id.."filteranimation"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.animation_.animation_.persistent_id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0,"🚹| العضـو -› {[@"..data.username_.."]}\n🚯| عذرا تم منع المتحركه \n") 
else
send(msg.chat_id_,0,"🚹| العضـو -› {["..data.first_name_.."](T.ME/TuBakx)}\n🚯| عذرا تم منع المتحركه \n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end

if text == 'تفعيل' and Sudo(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا \n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⚠️| عذرا يرجى ترقيه البوت مشرف !')
return false  
end
tdcli_function ({ ID = "GetChannelFull", channel_id_ = getChatId(msg.chat_id_).ID }, function(arg,data)  
if tonumber(data.member_count_) < tonumber(database:get(bot_id..'Num:Add:Bot') or 0) and not DevTuBacK(msg) then
send(msg.chat_id_, msg.id_,'🚻| عذراً عدد اعضاء المجموعة قليله العدد المطلوب لتفعيل البوت هـو -› {'..(database:get(bot_id..'Num:Add:Bot') or 0)..'} عضو 🗣️')
return false
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
if database:sismember(bot_id..'Chek:Groups',msg.chat_id_) then
send(msg.chat_id_, msg.id_,'✅| بالتأكيد تم تفعيل المجموعة ')
else
local Text = '🚹| تم تفعيل المجموعة {'..chat.title_..'}'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
database:sadd(bot_id..'Chek:Groups',msg.chat_id_)
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
local NameChat = chat.title_
local IdChat = msg.chat_id_
local NumMember = data.member_count_
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
Text = '☑️| تم تفعيل مجموعة جديدة\n\n'..
'\n🚹| بواسطة -› {'..Name..'}'..
'\n📌| موقـعة -› {'..AddPy..'}' ..
'\nٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯'..
'\n📫| *معلومات المجموعة ↓↑*'..
'\n🏷️| ايدي المجموعة -› {'..IdChat..'}'..
'\n🚻| عدد اعضاء المجموعة -› *{'..NumMember..'}*'..
'\n💭| اسم المجموعة -› {['..NameChat..']}'..
'\n🖇️| رابط المجموعة : {['..LinkGp..']}'
if not DevTuBacK(msg) then
sendText(SUDO,Text,0,'md')
end
end
end,nil) 
end,nil) 
end,nil)
end
if text == 'تعطيل' and Sudo(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا \n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
if not database:sismember(bot_id..'Chek:Groups',msg.chat_id_) then
send(msg.chat_id_, msg.id_,'✅| بالتأكيد تم تعطيل المجموعة ')
else
local Text = '🚺| تم تعطيل المجموعة {'..chat.title_..'}'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟ ',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
database:srem(bot_id..'Chek:Groups',msg.chat_id_)  
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
local NameChat = chat.title_
local IdChat = msg.chat_id_
local AddPy = var
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
Text = '☑️| تم تعطيل المجموعة \n\n'..
'\n🚹| بواسطة -› {'..Name..'}'..
'\n📌| موقـعة -› {'..AddPy..'}' ..
'\nٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯'..
'\n📫| *معلومات المجموعة ↓↑*'..
'\n🏷️| ايدي المجموعة -› {'..IdChat..'}'..
'\n🚻| عدد اعضاء المجموعة -› *{'..NumMember..'}*'..
'\n💭| اسم المجموعة -› {['..NameChat..']}'..
'\n🖇️| رابط المجموعة : {['..LinkGp..']}'
if not DevTuBacK(msg) then
sendText(SUDO,Text,0,'md')
end
end
end,nil) 
end,nil) 
end
if text == 'تفعيل' and not Sudo(msg) and not database:get(bot_id..'Free:Bots') then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا \n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⚠️| عذرا يرجى ترقيه البوت مشرف !')
return false  
end
tdcli_function ({ ID = "GetChannelFull", channel_id_ = getChatId(msg.chat_id_).ID }, function(arg,data)  
if tonumber(data.member_count_) < tonumber(database:get(bot_id..'Num:Add:Bot') or 0) and not DevTuBacK(msg) then
send(msg.chat_id_, msg.id_,'🚻| عذراً عدد اعضاء المجموعة قليله العدد المطلوب لتفعيل البوت هـو -› {'..(database:get(bot_id..'Num:Add:Bot') or 0)..'} عضو 🗣️')
return false
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da and da.status_.ID == "ChatMemberStatusEditor" or da and da.status_.ID == "ChatMemberStatusCreator" then
if da and da.user_id_ == msg.sender_user_id_ then
if da.status_.ID == "ChatMemberStatusCreator" then
var = 'المالك'
elseif da.status_.ID == "ChatMemberStatusEditor" then
var = 'مشرف'
end
if database:sismember(bot_id..'Chek:Groups',msg.chat_id_) then
send(msg.chat_id_, msg.id_,'✅| بالتأكيد تم تفعيل المجموعة')
else
local Text = '🚹| تم تفعيل المجموعة {'..chat.title_..'}'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟ ',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
database:sadd(bot_id..'Chek:Groups',msg.chat_id_)  
database:sadd(bot_id..'CoSu'..msg.chat_id_, msg.sender_user_id_)
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
local NumMember = data.member_count_
local NameChat = chat.title_
local IdChat = msg.chat_id_
local AddPy = var
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
Text = '☑️| تم تفعيل مجموعة جديدة\n\n'..
'\n🚹| بواسطة -› {'..Name..'}'..
'\n📌| موقـعة -› {'..AddPy..'}' ..
'\nٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯'..
'\n📫| *معلومات المجموعة ↓↑*'..
'\n🏷️| ايدي المجموعة -› {'..IdChat..'}'..
'\n🚻| عدد اعضاء المجموعة -› *{'..NumMember..'}*'..
'\n💭| اسم المجموعة -› {['..NameChat..']}'..
'\n🖇️| رابط المجموعة : {['..LinkGp..']}'
if not DevTuBacK(msg) then
sendText(SUDO,Text,0,'md')
end
end
end
end
end,nil)   
end,nil) 
end,nil) 
end,nil)
end
if text and text:match("^ضع عدد الاعضاء (%d+)$") and DevTuBacK(msg) then
local Num = text:match("ضع عدد الاعضاء (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id..'Num:Add:Bot',Num) 
send(msg.chat_id_, msg.id_,'🚻| تم تعيين عدد اعضاء المجموعات \n\nسيتم تفعيل البوت في المجموعة التي اعضائها اكثر من -› {'..Num..'} عضو')
end
if text == 'تحديث السورس' and DevTuBacK(msg) then 
os.execute('rm -rf TuBacK.lua')
os.execute('https://raw.githubusercontent.com/Tubaktele/TuBacK/main/TuBacK.lua')
send(msg.chat_id_, msg.id_,'☑️| تم تحديث السورس \n◀️| لديك اخر اصدار لسورس توباك\n🛡️| اصدار السورس -› (* v1.0*)')
dofile('TuBacK.lua')  
end

if text and text:match("^تغير الاشتراك 🏷️$") and DevTuBacK(msg) then  
database:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, '↪️| حسنآ ارسل لي معرف القناة')
return false  
end
if text and text:match("^تغير رساله الاشتراك 🗞️$") and DevTuBacK(msg) then  
database:setex(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, '↪️| حسنآ ارسل لي النص الذي تريده')
return false  
end
if text == "حذف رساله الاشتراك 🚸" and DevTuBacK(msg) then  
database:del(bot_id..'text:ch:user')
send(msg.chat_id_, msg.id_, "🚮| تم مسح رساله الاشتراك ")
return false  
end
if text and text:match("^وضع قناة الاشتراك ➗$") and DevTuBacK(msg) then  
database:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, '↪️| حسنآ ارسل لي معرف القناة')
return false  
end
if text == "تفعيل الاشتراك 🔔" and DevTuBacK(msg) then  
if database:get(bot_id..'add:ch:id') then
local addchusername = database:get(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_,"🚹| الاشتراك الاجباري مفعل \n◀️| على القناة -› ["..addchusername.."]")
else
database:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_," 👋🏻| اهلا عزيزي المطور \n↩️| ارسل الان معرف قناتك")
end
return false  
end
if text == "تفعيل الاشتراك 🚫" and DevTuBacK(msg) then  
database:del(bot_id..'add:ch:id')
database:del(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_, "❎| تم تعطيل الاشتراك الاجباري ")
return false  
end
if text == "الاشتراك الاجباري 💈" and DevTuBacK(msg) then  
if database:get(bot_id..'add:ch:username') then
local addchusername = database:get(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_, "☑️| تم تفعيل الاشتراك الاجباري \n◀️| على القناة -› ["..addchusername.."]")
else
send(msg.chat_id_, msg.id_, "ℹ️| لا يوجد قناة في الاشتراك الاجباري ")
end
return false  
end
if text == "تفعيل الاضافات" and SudoBot(msg) then
send(msg.chat_id_, msg.id_, '✅| تم تفعيل الاضافات')
database:set(bot_id.."AL:AddS0FI:stats","✔")
end
if text == "تعطيل الاضافات" and SudoBot(msg) then
send(msg.chat_id_, msg.id_, '❎| تم تعطيل الاضافات')
database:set(bot_id.."AL:AddS0FI:stats","✖")
end
if text == "حاله الاضافات" and Constructor(msg) then
local MRSoOoFi = database:get(bot_id.."AL:AddS0FI:stats") or "لم يتم التحديد"
send(msg.chat_id_, msg.id_,"حاله الاضافات هي : {"..MRSoOoFi.."}\nاذا كانت {✔} الاضافات مفعله\nاذا كانت {✖} الاضافات معطله")
end
function bnnaGet(user_id, cb)
tdcli_function ({
ID = "GetUser",
user_id_ = user_id
}, cb, nil)
end

if database:get(bot_id.."block:name:stats"..msg.chat_id_) == "open" then
if text and text:match("^كتم اسم (.*)$") and Manager(msg) and database:get(bot_id.."block:name:stats"..msg.chat_id_) == "open" then
local BlNe = text:match("^كتم اسم (.*)$")
send(msg.chat_id_, msg.id_, 'ℹ️| تم كتم الاسم '..BlNe)
database:sadd(bot_id.."TuBacK:blocname"..msg.chat_id_, BlNe)
end

if text and text:match("^الغاء كتم اسم (.*)$") and Manager(msg) and database:get(bot_id.."block:name:stats"..msg.chat_id_) == "open" then
local delBn = text:match("^الغاء كتم اسم (.*)$")
send(msg.chat_id_, msg.id_, '🚹| تم الغاء كتم الاسم '..delBn)
database:srem(bot_id.."TuBacK:blocname"..msg.chat_id_, delBn)
end

if text == "مسح الاسماء المكتومه" and Constructor(msg) and database:get(bot_id.."block:name:stats"..msg.chat_id_) == "open" then
database:del(bot_id.."TuBacK:blocname"..msg.chat_id_)
texts = "✅| تم مسح الاسماء المكتومه "
send(msg.chat_id_, msg.id_, texts)
end
if text == "الاسماء المكتومه" and Constructor(msg) and database:get(bot_id.."block:name:stats"..msg.chat_id_) == "open" then
local All_name = database:smembers(bot_id.."TuBacK:blocname"..msg.chat_id_)
t = "\n📋| قائمة الاسماء المكتومه \nٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ \n"
for k,v in pairs(All_name) do
t = t..""..k.."- (["..v.."])\n"
end
if #All_name == 0 then
t = "ℹ️| لا يوجد اسماء مكتومه"
end
send(msg.chat_id_, msg.id_, t)
end
end
if text == "تفعيل كتم الاسم" and Constructor(msg) and database:get(bot_id.."AL:AddS0FI:stats") == "✔" then
send(msg.chat_id_, msg.id_, '✅| تم التفعيل الاسماء المكتومه')
database:set(bot_id.."block:name:stats"..msg.chat_id_,"open")
end
if text == "تعطيل كتم الاسم" and Constructor(msg) and database:get(bot_id.."AL:AddS0FI:stats") == "✔" then
send(msg.chat_id_, msg.id_, '❎| تم تعطيل الاسماء المكتومه')
database:set(bot_id.."block:name:stats"..msg.chat_id_,"close")
end
if not Manager(msg) and database:get(bot_id.."block:name:stats"..msg.chat_id_) == "open" then
function VlVlVI_name(t1,t2)
if t2.id_ then 
name_MRAhMd = ((t2.first_name_ or "") .. (t2.last_name_ or ""))
if name_MRAhMd then 
names_MRAhMd = database:smembers(bot_id.."TuBacK:blocname"..msg.chat_id_) or ""
if names_MRAhMd and names_MRAhMd[1] then 
for i=1,#names_MRAhMd do 
if name_MRAhMd:match("(.*)("..names_MRAhMd[i]..")(.*)") then 
DeleteMessage_(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
end
end
end
bnnaGet(msg.sender_user_id_, VlVlVI_name)
end
if database:get(bot_id.."kt:twh:stats"..msg.chat_id_) == "open" then
if text and text:match("^وضع توحيد (.*)$") and Manager(msg) and database:get(bot_id.."kt:twh:stats"..msg.chat_id_) == "open" then
local teh = text:match("^وضع توحيد (.*)$")
send(msg.chat_id_, msg.id_,'☑️| تم تعين'..teh..' كتوحيد للمجموعه')
database:set(bot_id.."TuBacK:teh"..msg.chat_id_,teh)
end
if text and text:match("^تعين عدد الكتم (.*)$") and Manager(msg) and database:get(bot_id.."kt:twh:stats"..msg.chat_id_) == "open" then
local nump = text:match("^تعين عدد الكتم (.*)$")
send(msg.chat_id_, msg.id_,'🔢| تم تعين '..nump..' عدد الكتم')
database:set(bot_id.."TuBacK:nump"..msg.chat_id_,nump)
end
if text == "التوحيد" then
local s1 = database:get(bot_id.."TuBacK:teh"..msg.chat_id_) or "لا يوجد توحيد"
local s2 = database:get(bot_id.."TuBacK:nump"..msg.chat_id_) or 5
send(msg.chat_id_, msg.id_,'◀️| التوحيد '..s1..'\n| عدد الكتم  : '..s2)
end
end
if text == "تفعيل التوحيد" and Constructor(msg) and database:get(bot_id.."AL:AddS0FI:stats") == "✔" then
send(msg.chat_id_, msg.id_, '✅| تم تفعيل التوحيد')
database:set(bot_id.."kt:twh:stats"..msg.chat_id_,"open")
end
if text == "تعطيل التوحيد" and Constructor(msg) and database:get(bot_id.."AL:AddS0FI:stats") == "✔" then
send(msg.chat_id_, msg.id_, '❎| تم تعطيل التوحيد')
database:set(bot_id.."kt:twh:stats"..msg.chat_id_,"close")
end
if not Constructor(msg) then
if database:get(bot_id.."kt:twh:stats"..msg.chat_id_) == "open"  and database:get(bot_id.."TuBacK:teh"..msg.chat_id_) then 
id = msg.sender_user_id_
function ahmd_mrahmd_new(mrahmd1,mrahmd2)
if mrahmd2 and mrahmd2.first_name_ then 
if mrahmd2.first_name_:match("(.*)"..database:get(bot_id.."TuBacK:teh"..msg.chat_id_).."(.*)") then 
database:srem(bot_id.."TuBacK:Muted:User"..msg.chat_id_, msg.sender_user_id_)
else
local mrahmd_nnn = database:get(bot_id.."TuBacK:nump"..msg.chat_id_) or 5
local mrahmd_nnn2 = database:get(bot_id.."TuBacK:nump22"..msg.chat_id_..msg.sender_user_id_) or 0
if (tonumber(mrahmd_nnn2) == tonumber(mrahmd_nnn) or tonumber(mrahmd_nnn2) > tonumber(mrahmd_nnn)) then 
database:sadd(bot_id..'Muted:User'..msg.chat_id_, msg.sender_user_id_)
else 
database:incrby(bot_id.."TuBacK:nump22"..msg.chat_id_..msg.sender_user_id_,1)
send(msg.chat_id_, msg.id_, "🚹| عزيزي >>["..mrahmd2.username_.."](https://t.me/"..(mrahmd2.username_ or "TuBakx")..")\n▶️| عليك وضع التوحيد ⪼ {"..database:get(bot_id.."TuBacK:teh"..msg.chat_id_).."} بجانب اسمك\n🔢| عدد المحاولات المتبقيه {"..(tonumber(mrahmd_nnn) - tonumber(mrahmd_nnn2)).."}")
end
end
end
end
bnnaGet(id, ahmd_mrahmd_new)
end
end
if text == "تفعيل تنبيه الاسماء" and Manager(msg) and database:get(bot_id.."AL:AddS0FI:stats") == "✔" then
send(msg.chat_id_, msg.id_, '✅| تم تفعيل تنبيه الاسماء')
database:set(bot_id.."Ttn:DRG:stats"..msg.chat_id_,"open")
end
if text == "تعطيل تنبيه الاسماء" and Manager(msg) and database:get(bot_id.."AL:AddS0FI:stats") == "✔" then
send(msg.chat_id_, msg.id_, '❎| تم تعطيل تنبيه الاسماء')
database:set(bot_id.."Ttn:DRG:stats"..msg.chat_id_,"close")
end
if text and database:get(bot_id.."Ttn:DRG:stats"..msg.chat_id_) == "open" then 
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)
if data.id_ then 
if data.id_ ~= bot_id then
local TuBacKChengName = database:get(bot_id.."TuBacK:Cheng:Name"..data.id_)
if not data.first_name_ then 
if TuBacKChengName then 
send(msg.chat_id_, msg.id_, " خوش معرف جان ["..TuBacKChengName..']')
database:del(bot_id.."TuBacK:Cheng:Name"..data.id_) 
end
end
if data.first_name_ then 
if TuBacKChengName ~= data.first_name_ then 
local Text = {
  "جان خوش اسم يول",
"ليش غيرته اسمك بس لا خانوك/ج",
"هذا الحلو غير اسمه 😉",
}
send(msg.chat_id_, msg.id_,Text[math.random(#Text)])
end  
database:set(bot_id.."TuBacK:Cheng:Name"..data.id_, data.first_name_) 
end
end
end
end,nil)   
end
if text == "تفعيل تنبيه المعرف" and Constructor(msg) and database:get(bot_id.."AL:AddS0FI:stats") == "✔" then
send(msg.chat_id_, msg.id_, '❎| تم تفعيل تنبيه المعرف')
database:set(bot_id.."Ttn:Userr:stats"..msg.chat_id_,"open")
end
if text == "تعطيل تنبيه المعرف" and Constructor(msg) and database:get(bot_id.."AL:AddS0FI:stats") == "✔" then
send(msg.chat_id_, msg.id_, '❎| تم تعطيل تنبيه المعرف')
database:set(bot_id.."Ttn:Userr:stats"..msg.chat_id_,"close")
end
if text and database:get(bot_id.."Ttn:Userr:stats"..msg.chat_id_) == "open" then  
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)
if data.id_ then 
if data.id_ ~= bot_id then
local TuBacKChengUserName = database:get(bot_id.."TuBacK:Cheng:UserName"..data.id_)
if not data.username_ then 
if TuBacKChengUserName then 
send(msg.chat_id_, msg.id_, 1, "حذف معرفه خمطو بساع بساع  \n هاذه معرفه  : [@"..TuBacKChengUserName..']')
database:del(bot_id.."TuBacK:Cheng:UserName"..data.id_) 
end
end
if data.username_ then 
if TuBacKChengUserName ~= data.username_ then 
local Text = {
'شكو غيرت معرفك شنو نشروك بقنوات فضايح😂🥺',
"هاها شو غيرت معرفك بس لا هددتك/ج الحب",
"شسالفه شو غيرت معرفك 😐🌝",
"غير معرفه خمطو بساع بساع \n هاذه معرفه : @"..data.username_.."",
'ها عار مو جان معرفك \n شكو غيرته ل @'..data.username_..' ',
'ها يول شو مغير معرفك بيش مشتري يول', 
"منور معرف جديد :  "..data.username_.."",
}
send(msg.chat_id_, msg.id_,Text[math.random(#Text)])
end  
database:set(bot_id.."TuBacK:Cheng:UserName"..data.id_, data.username_) 
end
end
end
end,nil)   
end
if text == "تفعيل تنبيه الصور" and Manager(msg) and database:get(bot_id.."AL:AddS0FI:stats") == "✔" then
send(msg.chat_id_, msg.id_, '✅| تم تفعيل تنبيه الصور')
database:set(bot_id.."Ttn:Ph:stats"..msg.chat_id_,"open")
end
if text == "تعطيل تنبيه الصور" and Manager(msg) and database:get(bot_id.."AL:AddS0FI:stats") == "✔" then
send(msg.chat_id_, msg.id_, '❎| تم تعطيل تنبيه الصور')
database:set(bot_id.."Ttn:Ph:stats"..msg.chat_id_,"close")
end
if text and database:get(bot_id.."Ttn:Ph:stats"..msg.chat_id_) == "open" then  
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)
if data.id_ then 
if data.id_ ~= bot_id then 
local TuBacKChengPhoto = database:get(bot_id.."TuBacK:Cheng:Photo"..data.id_)
if not data.profile_photo_ then 
if TuBacKChengPhoto then 
send(msg.chat_id_, msg.id_, "حذف كل صور ابن الحلو شكد غبي لعد😂🥺")
database:del(bot_id.."TuBacK:Cheng:Photo"..data.id_) 
end
end
if data.profile_photo_.big_.persistent_id_ then 
if TuBacKChengPhoto ~= data.profile_photo_.big_.persistent_id_ then 
local Text = {
  "شكو غيرت صورتك يلصاك",
  "منور طالع حلو ع صوره جديده",
  "ها يول شو غيرت صورتك😍😂",
  "شكو غيرت صورتك شنو قطيت وحده جديده 😹😹🌚",
  "شو غيرت صورتك شنو تعاركت ويه الحب ؟😹🌞",
  "شكو غيرت الصوره شسالفه ؟؟ 🤔🌞",
}
send(msg.chat_id_, msg.id_,Text[math.random(#Text)])
end  
database:set(bot_id.."TuBacK:Cheng:Photo"..data.id_, data.profile_photo_.big_.persistent_id_) 
end
end
end
end,nil)  
end
if text == 'السورس' or text == 'سورس' or text == 'يا سورس' then
local url,res = https.request('https://anashtick.ml/TuBak.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.TuBak ~= true then
local inline = {{{text="اضغط هنا للشتراك 🚹",url="https://t.me/TuBakx"}}}
SendInline(msg.chat_id_,'عذراً عليك الاشتراك في [. Team TuBak](t.me/TuBaKx) \nليمكنك استخدام البوت بشكل كامل',nil,inline)
return false 
end
Text = [[
*أهلاً بك في سورس* [TuBaK Team 🔽](t.me/Tubakx)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'قناة السورس 📢',url="https://t.me/TuBaKx/16"},
},
{
{text = 'تواصل السورس 💭',url="t.me/Y_8ibot"},
},
{
{text = 'شروحات السورس 📑',url="t.me/TUBAKTEAM"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end
--------------------------------------------------------------------------------------------------------------
if Chat_Type == 'GroupBot' and ChekAdd(msg.chat_id_) == true then
if text == 'رفع نسخه الاحتياطيه' and DevTuBacK(msg) then   
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.document_ then 
local ID_FILE = result.content_.document_.document_.persistent_id_ 
local File_Name = result.content_.document_.file_name_
AddFile_Bot(msg,msg.chat_id_,ID_FILE,File_Name)
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text == 'جلب نسخه الاحتياطيه' and DevTuBacK(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
GetFile_Bot(msg)
end
if text == 'الاوامر المضافه' and Constructor(msg) then
local list = database:smembers(bot_id..'List:Cmd:Group:New'..msg.chat_id_..'')
t = "📋| قائمه الاوامر المضافه  \nٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯\n"
for k,v in pairs(list) do
Cmds = database:get(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..v)
print(Cmds)
if Cmds then 
t = t..""..k..">> ("..v..") -› {"..Cmds.."}\n"
else
t = t..""..k..">> ("..v..") \n"
end
end
if #list == 0 then
t = "⚠️| لا يوجد اوامر مضافه"
end
send(msg.chat_id_, msg.id_,'['..t..']')
end
if text == 'حذف الاوامر المضافه' or text == 'مسح الاوامر المضافه' then
if Constructor(msg) then 
local list = database:smembers(bot_id..'List:Cmd:Group:New'..msg.chat_id_)
for k,v in pairs(list) do
database:del(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..v)
database:del(bot_id..'List:Cmd:Group:New'..msg.chat_id_)
end
send(msg.chat_id_, msg.id_,'🚮| تم ازالة جميع الاوامر المضافه')  
end
end
if text == 'اضف امر' and Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id.."Set:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_,'true') 
send(msg.chat_id_, msg.id_,'↪️| ارسل الامر القديم')  
return false
end
if text == 'حذف امر' or text == 'مسح امر' then 
if Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id.."Del:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_,'true') 
send(msg.chat_id_, msg.id_,'↪️| ارسل الامر الذي قمت بوضعه بدلا عن القديم')  
return false
end
end
if text and database:get(bot_id.."Set:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_) == 'true' then
database:set(bot_id.."Set:Cmd:Group:New"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,'↪️| ارسل الامر الجديد')  
database:del(bot_id.."Set:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_)
database:set(bot_id.."Set:Cmd:Group1"..msg.chat_id_..':'..msg.sender_user_id_,'true1') 
return false
end
if text and database:get(bot_id.."Set:Cmd:Group1"..msg.chat_id_..':'..msg.sender_user_id_) == 'true1' then
local NewCmd = database:get(bot_id.."Set:Cmd:Group:New"..msg.chat_id_)
database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..text,NewCmd)
database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,'✅| تم حفظ الامر')  
database:del(bot_id.."Set:Cmd:Group1"..msg.chat_id_..':'..msg.sender_user_id_)
return false
end
--------------------------------------------------------------------------------------------------------------
if text == 'قفل الدردشه' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id.."lock:text"..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)  
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الدردشه ')
end,nil)   
elseif text == 'قفل الاضافه' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id.."lock:AddMempar"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل اضافة ')
end,nil)   
elseif text == 'قفل الدخول' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id.."lock:Join"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل دخول ')
end,nil)   
elseif text == 'قفل البوتات' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id.."lock:Bot:kick"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل البوتات ')
end,nil)   
elseif text == 'قفل البوتات بالطرد' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id.."lock:Bot:kick"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل البوتات بالطرد ')
end,nil)   
elseif text == 'قفل الاشعارات' and msg.reply_to_message_id_ == 0 and Mod(msg) then  
database:set(bot_id..'lock:tagservr'..msg.chat_id_,true)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الاشعارات ')
end,nil)   
elseif text == 'قفل التثبيت' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:set(bot_id.."lockpin"..msg.chat_id_, true) 
database:sadd(bot_id..'lock:pin',msg.chat_id_) 
tdcli_function ({ ID = "GetChannelFull",  channel_id_ = getChatId(msg.chat_id_).ID }, function(arg,data)  database:set(bot_id..'Pin:Id:Msg'..msg.chat_id_,data.pinned_message_id_)  end,nil)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل التثبيت ')
end,nil)   
elseif text == 'قفل التعديل' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:set(bot_id..'lock:edit'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل تعديل ')
end,nil)   
elseif text == 'قفل الفشار' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id..'lock:Fshar'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الفشار ')
end,nil)  
elseif text == 'قفل الفارسيه' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id..'lock:Fars'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الفارسيه ')
end,nil)   
elseif text == 'قفل الانكليزيه' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id..'lock:Engilsh'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الانكليزيه ')
end,nil)
elseif text == 'قفل الانلاين' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id.."lock:inline"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الانلاين ')
end,nil)
elseif text == 'قفل تعديل الميديا' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:set(bot_id..'lock_edit_med'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل تعديل ')
end,nil)    
elseif text == 'قفل الكل' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id..'lock:tagservrbot'..msg.chat_id_,true)   
list ={"lock:Bot:kick","lock:user:name","lock:hashtak","lsock:Cmd","lock:Link","lock:forward","lock:Keyboard","lock:geam","lock:Photo","lock:Animation","lock:Video","lock:Audio","lock:vico","lock:Sticker","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:set(bot_id..lock..msg.chat_id_,'del')    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل جميع الاوامر ')
end,nil)   
end
if text == 'قفل الاباحي' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Lock:Sexy"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الاباحي ')
end,nil)   
elseif text == 'فتح الاباحي' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Lock:Sexy"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n✅| تـم فتح الاباحي ')
end,nil)   
end
if text == 'فتح الانلاين' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:inline"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n✅| تـم فتح الانلاين ')
end,nil)
elseif text == 'فتح الاضافه' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:AddMempar"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n✅| تـم فتح اضافة ')
end,nil)   
elseif text == 'فتح الدردشه' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:del(bot_id.."lock:text"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n✅| تـم فتح الدردشه ')
end,nil)   
elseif text == 'فتح الدخول' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:Join"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n✅| تـم فتح دخول ')
end,nil)   
elseif text == 'فتح البوتات' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:Bot:kick"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n✅| تـم فـتح البوتات ')
end,nil)   
elseif text == 'فتح البوتات بالطرد' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:Bot:kick"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n✅| تـم فـتح البوتات بالطرد ')
end,nil)   
elseif text == 'فتح الاشعارات' and msg.reply_to_message_id_ == 0 and Mod(msg) then  
database:del(bot_id..'lock:tagservr'..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n✅| تـم فـتح الاشعارات ')
end,nil)   
elseif text == 'فتح التثبيت' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:del(bot_id.."lockpin"..msg.chat_id_)  
database:srem(bot_id..'lock:pin',msg.chat_id_)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n✅| تـم فـتح التثبيت ')
end,nil)   
elseif text == 'فتح التعديل' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:del(bot_id..'lock:edit'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n✅| تـم فـتح تعديل ')
end,nil)   
elseif text == 'فتح الفشار' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:del(bot_id..'lock:Fshar'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n✅| تـم فـتح الفشار ')
end,nil)   
elseif text == 'فتح الفارسيه' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:del(bot_id..'lock:Fars'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n✅| تـم فـتح الفارسيه ')
end,nil)   
elseif text == 'فتح الانكليزيه' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:del(bot_id..'lock:Engilsh'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n✅| تـم فـتح الانكليزيه ')
end,nil)
elseif text == 'فتح تعديل الميديا' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:del(bot_id..'lock_edit_med'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n✅| تـم فـتح تعديل ')
end,nil)    
elseif text == 'فتح الكل' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id..'lock:tagservrbot'..msg.chat_id_)   
list ={"lock:Bot:kick","lock:user:name","lock:hashtak","lock:Cmd","lock:Link","lock:forward","lock:Keyboard","lock:geam","lock:Photo","lock:Animation","lock:Video","lock:Audio","lock:vico","lock:Sticker","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:del(bot_id..lock..msg.chat_id_)    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n✅| تـم فـتح جميع الاوامر ')
end,nil)   
end
if text == 'قفل الروابط' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Link"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الروابط ')
end,nil)   
elseif text == 'قفل الروابط بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Link"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الروابط بالتقييد ')
end,nil)   
elseif text == 'قفل الروابط بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Link"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الروابط بالكتم ')
end,nil)   
elseif text == 'قفل الروابط بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Link"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الروابط بالطرد ')
end,nil)   
elseif text == 'فتح الروابط' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Link"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n✅| تـم فتح الروابط ')
end,nil)   
end
if text == 'قفل المعرفات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:user:name"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل المعرفات ')
end,nil)   
elseif text == 'قفل المعرفات بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:user:name"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n✅| تـم قفـل المعرفات بالتقييد ')
end,nil)   
elseif text == 'قفل المعرفات بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:user:name"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل المعرفات بالكتم ')
end,nil)   
elseif text == 'قفل المعرفات بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:user:name"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل المعرفات بالطرد ')
end,nil)   
elseif text == 'فتح المعرفات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:user:name"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n✅| تـم فتح المعرفات ')
end,nil)   
end
if text == 'تفعيل all' and CoSu(msg) then   
if database:get(bot_id..'Cick:all'..msg.chat_id_) then
Text = '✅| تم تفعيل امر @all'
database:del(bot_id..'Cick:all'..msg.chat_id_)  
else
Text = '✅| بالتاكيد تم تفعيل امر @all'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل all' and CoSu(msg) then  
if not database:get(bot_id..'Cick:all'..msg.chat_id_) then
database:set(bot_id..'Cick:all'..msg.chat_id_,true)  
Text = '\n❎| تم تعطيل امر @all'
else
Text = '\n❎| بالتاكيد تم تعطيل امر @all'
end
send(msg.chat_id_, msg.id_,Text) 
end

if text == 'قفل التاك' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:hashtak"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل التاك ')
end,nil)   
elseif text == 'قفل التاك بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:hashtak"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل التاك بالتقييد ')
end,nil)   
elseif text == 'قفل التاك بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:hashtak"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..string.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل التاك بالكتم ')
end,nil)   
elseif text == 'قفل التاك بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:hashtak"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل التاك بالطرد ')
end,nil)   
elseif text == 'فتح التاك' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:hashtak"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n✅| تـم فتح التاك ')
end,nil)   
end
if text == 'قفل الشارحه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Cmd"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الشارحه ')
end,nil)   
elseif text == 'قفل الشارحه بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Cmd"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الشارحه بالتقييد ')
end,nil)   
elseif text == 'قفل الشارحه بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Cmd"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الشارحه بالكتم ')
end,nil)   
elseif text == 'قفل الشارحه بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Cmd"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الشارحه بالطرد ')
end,nil)   
elseif text == 'فتح الشارحه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Cmd"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n✅| تـم فتح الشارحه ')
end,nil)   
end
if text == 'قفل الصور'and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Photo"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الصور ')
end,nil)   
elseif text == 'قفل الصور بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Photo"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الصور بالتقييد ')
end,nil)   
elseif text == 'قفل الصور بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Photo"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الصور بالكتم ')
end,nil)   
elseif text == 'قفل الصور بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Photo"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الصور بالطرد ')
end,nil)   
elseif text == 'فتح الصور' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Photo"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n✅| تـم فتح الصور ')
end,nil)   
end
if text == 'قفل الفيديو' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Video"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الفيديو ')
end,nil)   
elseif text == 'قفل الفيديو بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Video"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الفيديو بالتقييد ')
end,nil)   
elseif text == 'قفل الفيديو بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Video"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الفيديو بالكتم ')
end,nil)   
elseif text == 'قفل الفيديو بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Video"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الفيديو بالطرد ')
end,nil)   
elseif text == 'فتح الفيديو' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Video"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n✅|  تـم فتح الفيديو ')
end,nil)   
end
if text == 'قفل المتحركه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Animation"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل المتحركه ')
end,nil)   
elseif text == 'قفل المتحركه بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Animation"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل المتحركه بالتقييد ')
end,nil)   
elseif text == 'قفل المتحركه بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Animation"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل المتحركه بالكتم ')
end,nil)   
elseif text == 'قفل المتحركه بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Animation"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل المتحركه بالطرد ')
end,nil)   
elseif text == 'فتح المتحركه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Animation"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n✅| تـم فتح المتحركه ')
end,nil)   
end
if text == 'قفل الالعاب' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:geam"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الالعاب ')
end,nil)   
elseif text == 'قفل الالعاب بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:geam"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الالعاب بالتقييد ')
end,nil)   
elseif text == 'قفل الالعاب بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:geam"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الالعاب بالكتم ')
end,nil)   
elseif text == 'قفل الالعاب بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:geam"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الالعاب بالطرد ')
end,nil)   
elseif text == 'فتح الالعاب' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:geam"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n✅| تـم فتح الالعاب ')
end,nil)   
end
if text == 'قفل الاغاني' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Audio"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الاغاني ')
end,nil)   
elseif text == 'قفل الاغاني بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Audio"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الاغاني بالتقييد ')
end,nil)   
elseif text == 'قفل الاغاني بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Audio"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الاغاني بالكتم ')
end,nil)   
elseif text == 'قفل الاغاني بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Audio"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الاغاني بالطرد ')
end,nil)   
elseif text == 'فتح الاغاني' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Audio"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n✅| تـم فتح الاغاني ')
end,nil)   
end
if text == 'قفل الصوت' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:vico"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الصوت ')
end,nil)   
elseif text == 'قفل الصوت بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:vico"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الصوت بالتقييد ')
end,nil)   
elseif text == 'قفل الصوت بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:vico"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الصوت بالكتم ')
end,nil)   
elseif text == 'قفل الصوت بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:vico"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الصوت بالطرد ')
end,nil)   
elseif text == 'فتح الصوت' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:vico"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n✅| تـم فتح الصوت ')
end,nil)   
end
if text == 'قفل الكيبورد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Keyboard"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الكيبورد ')
end,nil)   
elseif text == 'قفل الكيبورد بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Keyboard"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الكيبورد بالتقييد ')
end,nil)   
elseif text == 'قفل الكيبورد بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Keyboard"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الكيبورد بالكتم ')  
end,nil)   
elseif text == 'قفل الكيبورد بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Keyboard"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الكيبورد بالطرد ')  
end,nil)   
elseif text == 'فتح الكيبورد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Keyboard"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n✅| تـم فتح الكيبورد ')  
end,nil)   
end
if text == 'قفل الملصقات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الملصقات ')  
end,nil)   
elseif text == 'قفل الملصقات بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الملصقات بالتقييد ')  
end,nil)
elseif text == 'قفل الملصقات بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الملصقات بالكتم ')  
end,nil)   
elseif text == 'قفل الملصقات بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الملصقات بالطرد ')  
end,nil)   
elseif text == 'فتح الملصقات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Sticker"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n✅| تـم فتح الملصقات ')  
end,nil)   
end
if text == 'قفل التوجيه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:forward"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل التوجيه ')  
end,nil)   
elseif text == 'قفل التوجيه بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:forward"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل التوجيه بالتقييد ')  
end,nil)
elseif text == 'قفل التوجيه بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:forward"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل التوجيه بالكتم ')  
end,nil)   
elseif text == 'قفل التوجيه بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:forward"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل التوجيه بالطرد ')  
end,nil)   
elseif text == 'فتح التوجيه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:forward"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n✅| تـم فتح التوجيه ')  
end,nil)   
end
if text == 'قفل الملفات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Document"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الملفات ')  
end,nil)   
elseif text == 'قفل الملفات بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Document"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الملفات بالتقييد ')  
end,nil)
elseif text == 'قفل الملفات بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Document"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الملفات بالكتم ')  
end,nil)   
elseif text == 'قفل الملفات بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Document"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الملفات بالطرد ')  
end,nil)   
elseif text == 'فتح الملفات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Document"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n✅| تـم فتح الملفات ')  
end,nil)   
end
if text == 'قفل السيلفي' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Unsupported"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل السيلفي ')  
end,nil)   
elseif text == 'قفل السيلفي بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Unsupported"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل السيلفي بالتقييد ')  
end,nil)
elseif text == 'قفل السيلفي بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Unsupported"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل السيلفي بالكتم ')  
end,nil)   
elseif text == 'قفل السيلفي بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Unsupported"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل السيلفي بالطرد ')  
end,nil)   
elseif text == 'فتح السيلفي' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Unsupported"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n✅| تـم فتح السيلفي ')  
end,nil)   
end
if text == 'قفل الماركداون' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Markdaun"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الماركداون ')  
end,nil)   
elseif text == 'قفل الماركداون بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Markdaun"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الماركداون بالتقييد ')  
end,nil)
elseif text == 'قفل الماركداون بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Markdaun"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الماركداون بالكتم ')  
end,nil)   
elseif text == 'قفل الماركداون بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Markdaun"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الماركداون بالطرد ')  
end,nil)   
elseif text == 'فتح الماركداون' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Markdaun"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n✅| تـم فتح الماركداون ')  
end,nil)   
end
if text == 'قفل الجهات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Contact"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الجهات ')  
end,nil)   
elseif text == 'قفل الجهات بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Contact"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الجهات بالتقييد ')  
end,nil)
elseif text == 'قفل الجهات بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Contact"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الجهات بالكتم ')  
end,nil)   
elseif text == 'قفل الجهات بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Contact"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الجهات بالطرد ')  
end,nil)   
elseif text == 'فتح الجهات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Contact"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n✅| تـم فتح الجهات ')  
end,nil)   
end
if text == 'قفل الكلايش' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Spam"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الكلايش ')  
end,nil)   
elseif text == 'قفل الكلايش بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Spam"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الكلايش بالتقييد ')  
end,nil)
elseif text == 'قفل الكلايش بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Spam"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الكلايش بالكتم ')  
end,nil)   
elseif text == 'قفل الكلايش بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Spam"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل الكلايش بالطرد ')  
end,nil)   
elseif text == 'فتح الكلايش' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Spam"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n✅| تـم فتح الكلايش ')  
end,nil)   
end
if text == 'قفل التكرار بالطرد' and Mod(msg) then 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'kick')  
send(msg.chat_id_, msg.id_,'❎|  تم قفل التكرار بالطرد')
elseif text == 'قفل التكرار' and Mod(msg) then 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'del')  
send(msg.chat_id_, msg.id_,'❎| تم قفل التكرار')
elseif text == 'قفل التكرار بالتقييد' and Mod(msg) then 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'keed')  
send(msg.chat_id_, msg.id_,'❎| تم قفل التكرار بالتقييد')
elseif text == 'قفل التكرار بالكتم' and Mod(msg) then 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'mute')  
send(msg.chat_id_, msg.id_,'❎| تم قفل التكرار بالكتم')
elseif text == 'فتح التكرار' and Mod(msg) then 
database:hdel(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood")  
send(msg.chat_id_, msg.id_,'✅| تم فتح التكرار')
end
--------------------------------------------------------------------------------------------------------------
if text == 'تحديث' and DevTuBacK(msg) then    
dofile('TuBacK.lua')  
send(msg.chat_id_, msg.id_, '☑️| تم تحديث جميع الملفات') 
end 
if text == ("مسح قائمه العام") and DevTuBacK(msg) then
database:del(bot_id..'GBan:User')
send(msg.chat_id_, msg.id_, '\n✅| تم مسح قائمه العام')
return false
end
if text == ("قائمه العام") and DevTuBacK(msg) then
local list = database:smembers(bot_id..'GBan:User')
t = "\n📋| قائمة المحظورين عام \nٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "⚠️| لا يوجد محظورين عام"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text == ("حظر عام") and msg.reply_to_message_id_ and DevTuBacK(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.sender_user_id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "ℹ️| لا يمكنك حظر المطور الاساسي \n")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠️| لا تسطيع حظر البوت عام")
return false 
end
database:sadd(bot_id..'GBan:User', result.sender_user_id_)
chat_kick(result.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},
function(arg,data) 
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n🚷| تم حظره عام من المجموعات'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^حظر عام @(.*)$")  and DevTuBacK(msg) then
local username = text:match("^حظر عام @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠️| لا تسطيع حظر البوت عام")
return false 
end
if result.id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "ℹ️| لا يمكنك حظر المطور الاساسي \n")
return false 
end
usertext = '\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(username or 'TuBakx')..')'
status  = '\n🚷| تم حظره عام من المجموعات'
texts = usertext..status
database:sadd(bot_id..'GBan:User', result.id_)
else
texts = '⚠️| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^حظر عام (%d+)$") and DevTuBacK(msg) then
local userid = text:match("^حظر عام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if userid == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "ℹ️| لا يمكنك حظر المطور الاساسي \n")
return false 
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠️| لا تسطيع حظر البوت عام")
return false 
end
database:sadd(bot_id..'GBan:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n🚷| تم حظره عام من المجموعات'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n🚹꒐ العضو :  '..userid..''
status  = '\n🚷| تم حظره عام من المجموعات'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("كتم عام") and msg.reply_to_message_id_ and DevTuBacK(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.sender_user_id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "ℹ️| لا يمكنك كتم المطور الاساسي \n")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ⚠️| لا تسطيع كتم البوتعام")
return false 
end
database:sadd(bot_id..'Gmute:User', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},
function(arg,data) 
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n🚷| تم كتمه في المجموعة عام من الكروبات'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^كتم عام @(.*)$")  and DevTuBacK(msg) then
local username = text:match("^كتم عام @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ⚠️| لا تسطيع كتم البوتعام")
return false 
end
if result.id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "ℹ️| لا يمكنك كتم المطور الاساسي \n")
return false 
end
usertext = '\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(username or 'TuBakx')..')'
status  = '\n🚷| تم كتمه في المجموعة عام من الكروبات'
texts = usertext..status
database:sadd(bot_id..'Gmute:User', result.id_)
else
texts = '⚠️| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^كتم عام (%d+)$") and DevTuBacK(msg) then
local userid = text:match("^كتم عام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if userid == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "ℹ️| لا يمكنك كتم المطور الاساسي \n")
return false 
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ⚠️| لا تسطيع كتم البوتعام")
return false 
end
database:sadd(bot_id..'Gmute:User', userid)

tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n🚷| تم كتمه في المجموعة عام من الكروبات'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n🚹꒐ العضو :  '..userid..''
status  = '\n🚷| تم كتمه في المجموعة عام من الكروبات'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("الغاء العام") and msg.reply_to_message_id_ and DevTuBacK(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n🚷| تم الغاء (الحظر-الكتم) عام من المجموعات'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
database:srem(bot_id..'GBan:User', result.sender_user_id_)
database:srem(bot_id..'Gmute:User', result.sender_user_id_)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^الغاء العام @(.*)$") and DevTuBacK(msg) then
local username = text:match("^الغاء العام @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
usertext = '\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(username or 'TuBakx')..')'
status  = '\n🚷| تم الغاء (الحظر-الكتم) عام من المجموعات'
texts = usertext..status
database:srem(bot_id..'GBan:User', result.id_)
database:srem(bot_id..'Gmute:User', result.id_)
else
texts = '⚠️| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^الغاء العام (%d+)$") and DevTuBacK(msg) then
local userid = text:match("^الغاء العام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'GBan:User', userid)
database:srem(bot_id..'Gmute:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n🚷| تم الغاء (الحظر-الكتم) عام من المجموعات'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n🚹꒐ العضو :  '..userid..''
status  = '\n🚷| تم حظره عام من المجموعات'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == ("مسح المطورين") and DevTuBacK(msg) then
database:del(bot_id..'Sudo:User')
send(msg.chat_id_, msg.id_, "\n🚮| تم مسح قائمة المطورين  ")
end
if text == ("المطورين") and DevTuBacK(msg) then
local list = database:smembers(bot_id..'Sudo:User')
t = "\n📋| قائمة مطورين البوت \nٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "⚠️| لا يوجد مطورين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == "all" or text == "@all" and CoSu(msg) then
if not database:get(bot_id..'Cick:all'..msg.chat_id_) then
if database:get(bot_id.."VlVlVI:all:Time"..msg.chat_id_..':'..msg.sender_user_id_) then  
return 
send(msg.chat_id_, msg.id_,"انتظر دقيقه من فضلك")
end
database:setex(bot_id..'VlVlVI:all:Time'..msg.chat_id_..':'..msg.sender_user_id_,300,true)
tdcli_function({ID="GetChannelFull",channel_id_ = msg.chat_id_:gsub('-100','')},function(argg,dataa) 
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100',''), offset_ = 0,limit_ = dataa.member_count_},function(ta,ahmd)
x = 0
tags = 0
local list = ahmd.members_
for k, v in pairs(list) do
tdcli_function({ID="GetUser",user_id_ = v.user_id_},function(arg,data)
if x == 5 or x == tags or k == 0 then
tags = x + 5
t = "#all"
end
x = x + 1
tagname = data.first_name_
tagname = tagname:gsub("]","")
tagname = tagname:gsub("[[]","")
t = t..", ["..tagname.."](tg://user?id="..v.user_id_..")"
if x == 5 or x == tags or k == 0 then
local Text = t:gsub('#all,','#all\n')
sendText(msg.chat_id_,Text,0,'md')
end
end,nil)
end
end,nil)
end,nil)
end
end
if text == ("رفع مطور") and msg.reply_to_message_id_ and DevTuBacK(msg) then
function start_function(extra, result, success)
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'\n🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Sudo:User', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n⏫| تم ترقيته مطور'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false 
end
if text and text:match("^رفع مطور @(.*)$") and DevTuBacK(msg) then
local username = text:match("^رفع مطور @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Sudo:User', result.id_)
usertext = '\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(username or 'TuBakx')..')'
status  = '\n⏫| تم ترقيته مطور'
texts = usertext..status
else
texts = '⚠️| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false 
end
if text and text:match("^رفع مطور (%d+)$") and DevTuBacK(msg) then
local userid = text:match("^رفع مطور (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n⏫| تم ترقيته مطور'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n🚹꒐ العضو :  '..userid..''
status  = '\n⏫| تم ترقيته مطور'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text == ("تنزيل مطور") and msg.reply_to_message_id_ and DevTuBacK(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Sudo:User', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n⏬| تم تنزيله من المطورين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false 
end
if text and text:match("^تنزيل مطور @(.*)$") and DevTuBacK(msg) then
local username = text:match("^تنزيل مطور @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Sudo:User', result.id_)
usertext = '\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(username or 'TuBakx')..')'
status  = '\n⏬| تم تنزيله من المطورين'
texts = usertext..status
else
texts = '⚠️| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مطور (%d+)$") and DevTuBacK(msg) then
local userid = text:match("^تنزيل مطور (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n⏬| تم تنزيله من المطورين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n🚹꒐ العضو :  '..userid..''
status  = '\n⏬| تم تنزيله من المطورين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text == ("مسح قائمه المالك") and Sudo(msg) then
database:del(bot_id..'CoSu'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n✅| تم مسح قائمه المالك')
return false
end

if text == 'قائمه المالك' and Sudo(msg) then
local list = database:smembers(bot_id..'CoSu'..msg.chat_id_)
t = "\n📋| قائمه المالك \nٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "⚠️| لا يوجد احد في قائمه المالك"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text == ("رفع مالك") and msg.reply_to_message_id_ and Sudo(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n⏫| تم ترقيتة مالك المجموعة'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع مالك @(.*)$") and Sudo(msg) then
local username = text:match("^رفع مالك @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'CoSu'..msg.chat_id_, result.id_)
usertext = '\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(username or 'TuBakx')..')'
status  = '\n⏫| تم ترقيتة مالك المجموعة'
texts = usertext..status
else
texts = '⚠️| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع مالك (%d+)$") and Sudo(msg) then
local userid = text:match("^رفع مالك (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'CoSu'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n⏫| تم ترقيتة مالك المجموعة'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n🚹꒐ العضو :  '..userid..''
status  = '\n⏫| تم ترقيتة مالك المجموعة'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل مالك") and msg.reply_to_message_id_ and Sudo(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n⏬| تم تنزيله مالكي المجموعة'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل مالك @(.*)$") and Sudo(msg) then
local username = text:match("^تنزيل مالك @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'CoSu'..msg.chat_id_, result.id_)
usertext = '\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(username or 'TuBakx')..')'
status  = '\n⏬| تم تنزيله مالكي المجموعة'
texts = usertext..status
else
texts = '⚠️| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل مالك (%d+)$") and Sudo(msg) then
local userid = text:match("^تنزيل مالك (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'CoSu'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n⏬| تم تنزيله مالكي المجموعة'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n🚹꒐ العضو :  '..userid..''
status  = '\n⏬| تم تنزيله مالكي المجموعة'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------

if (msg.content_.sticker_)  and msg.reply_to_message_id_ == 0 and database:get(bot_id.."lock:Lock:Sexy"..msg.chat_id_)=="del" then      
sticker_id = msg.content_.sticker_.sticker_.persistent_id_
st = https.request('https://black-source.tk/BlackTeAM/ImageInfo.php?token='..token..'&url='..sticker_id.."&type=sticker")
eker = JSON.decode(st)
if eker.ok.Info == "Indecent" then
local list = database:smembers(bot_id.."Basic:Constructor"..msg.chat_id_)
t = "⚠️| يا منشئين تعالوو \nٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "⚠️| لا يوجد منشئين"
end
Reply_Status(msg,msg.sender_user_id_,"reply","🚯| قام بنشر ملصق اباحيه\n"..t)  
DeleteMessage(msg.chat_id_,{[0] = tonumber(msg.id_),msg.id_})   
end   
end
if (msg.content_.photo_) and msg.reply_to_message_id_ == 0 and database:get(bot_id.."lock:Lock:Sexy"..msg.chat_id_)=="del" then
photo_id = msg.content_.photo_.sizes_[1].photo_.persistent_id_  
Srrt = https.request('https://black-source.tk/BlackTeAM/ImageInfo.php?token='..token..'&url='..photo_id.."&type=photo")
Sto = JSON.decode(Srrt)
if Sto.ok.Info == "Indecent" then
local list = database:smembers(bot_id.."Basic:Constructor"..msg.chat_id_)
t = "⚠️| يا منشئين تعالو \nٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "⚠️| لايوجد منشئين"
end
Reply_Status(msg,msg.sender_user_id_,"reply","🚯| قام بنشر صوره اباحيه\n"..t)  
DeleteMessage(msg.chat_id_,{[0] = tonumber(msg.id_),msg.id_})   
end   
end
if text == 'تفعيل التحويل' and CoSu(msg) then   
if database:get(bot_id..'DRAGOON:change:ahmd'..msg.chat_id_) then
Text = '✅| تم تفعيل تحويل الصيغ'
database:del(bot_id..'DRAGOON:change:ahmd'..msg.chat_id_)  
else
Text = '☑️| بالتاكيد تم تفعيل امر تحويل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل التحويل' and CoSu(msg) then  
if not database:get(bot_id..'DRAGOON:change:ahmd'..msg.chat_id_) then
database:set(bot_id..'DRAGOON:change:ahmd'..msg.chat_id_,true)  
Text = '\n❎| تم تعطيل امر تحويل'
else
Text = '\n❎| بالتاكيد تم تعطيل امر تحويل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تحويل' and not database:get(bot_id..'DRAGOON:change:ahmd'..msg.chat_id_) then  
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.photo_ then 
local pn = result.content_.photo_.sizes_[1].photo_.persistent_id_
Addsticker(msg,msg.chat_id_,pn,msg.sender_user_id_..'.png')
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text == 'تحويل' and not database:get(bot_id..'DRAGOON:change:ahmd'..msg.chat_id_) then  
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.voice_ then 
local mr = result.content_.voice_.voice_.persistent_id_ 
Addmp3(msg,msg.chat_id_,mr,msg.sender_user_id_..'.mp3')
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text == 'تحويل' and not database:get(bot_id..'DRAGOON:change:ahmd'..msg.chat_id_) then  
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.audio_ then 
local mr = result.content_.audio_.audio_.persistent_id_
Addvoi(msg,msg.chat_id_,mr,msg.sender_user_id_..'.ogg')
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text == 'تحويل' and not database:get(bot_id..'DRAGOON:change:ahmd'..msg.chat_id_) then  
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.sticker_ then 
local Str = result.content_.sticker_.sticker_.persistent_id_ 
Addjpg(msg,msg.chat_id_,Str,msg.sender_user_id_..'.jpg')
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
-------------------
------------------------------------------------------------------------
if text == ("مسح الاساسين") and CoSu(msg) then
database:del(bot_id..'Basic:Constructor'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n✅| تم مسح منشئين المجموعةالاساسين')
return false
end
if text == 'المنشئين الاساسين' and CoSu(msg) then
local list = database:smembers(bot_id..'Basic:Constructor'..msg.chat_id_)
t = "\n📋| قائمة المنشئين الاساسين \nٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "⚠️| لا يوجد منشئين اساسين"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text == ("رفع منشئ اساسي") and msg.reply_to_message_id_ and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Basic:Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n⏫| تم ترقيته منشئ اساسي'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع منشئ اساسي @(.*)$") and CoSu(msg) then
local username = text:match("^رفع منشئ اساسي @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Basic:Constructor'..msg.chat_id_, result.id_)
usertext = '\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(username or 'TuBakx')..')'
status  = '\n⏫| تم ترقيته منشئ اساسي'
texts = usertext..status
else
texts = '⚠️| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع منشئ اساسي (%d+)$") and CoSu(msg) then
local userid = text:match("^رفع منشئ اساسي (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Basic:Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n⏫| تم ترقيته منشئ اساسي'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n🚹꒐ العضو :  '..userid..''
status  = '\n⏫| تم ترقيته منشئ اساسي'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل منشئ اساسي") and msg.reply_to_message_id_ and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n⏬| تم تنزيله من الاساسيين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل منشئ اساسي @(.*)$") and CoSu(msg) then
local username = text:match("^تنزيل منشئ اساسي @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_, result.id_)
usertext = '\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(username or 'TuBakx')..')'
status  = '\n⏬| تم تنزيله من الاساسيين'
texts = usertext..status
else
texts = '⚠️| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل منشئ اساسي (%d+)$") and CoSu(msg) then
local userid = text:match("^تنزيل منشئ اساسي (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n⏬| تم تنزيله من الاساسيين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n🚹꒐ العضو :  '..userid..''
status  = '\n⏬| تم تنزيله من الاساسيين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == 'مسح المنشئين' and BasicConstructor(msg) then
database:del(bot_id..'Constructor'..msg.chat_id_)
texts = '✅| تم مسح منشئين المجموعة'
send(msg.chat_id_, msg.id_, texts)
end

if text == ("المنشئين") and BasicConstructor(msg) then
local list = database:smembers(bot_id..'Constructor'..msg.chat_id_)
t = "\n📋| قائمة المنشئين \nٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "⚠️| لا يوجد منشئين"
end
send(msg.chat_id_, msg.id_, t)
end
if text ==("المنشئ") then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
owner_id = admins[i].user_id_
tdcli_function ({ID = "GetUser",user_id_ = owner_id},function(arg,b) 
if b.first_name_ == false then
send(msg.chat_id_, msg.id_,"ℹ️| حساب المنشئ محذوف")
return false  
end
local UserName = (b.username_ or "SRC-TuBacK")
send(msg.chat_id_, msg.id_,"🚹| منشئ المجموعة -› ["..b.first_name_.."](T.me/"..UserName..")")  
end,nil)   
end
end
end,nil)   
end
if text == "رفع منشئ" and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n⏫| تم ترقيته منشئ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text and text:match("^رفع منشئ @(.*)$") and BasicConstructor(msg) then
local username = text:match("^رفع منشئ @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Constructor'..msg.chat_id_, result.id_)
usertext = '\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(username or 'TuBakx')..')'
status  = '\n⏫| تم ترقيته منشئ'
texts = usertext..status
else
texts = '⚠️| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
------------------------------------------------------------------------
if text and text:match("^رفع منشئ (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^رفع منشئ (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n⏫| تم ترقيته منشئ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n🚹꒐ العضو :  '..userid..''
status  = '\n⏫| تم ترقيته منشئ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
if text and text:match("^تنزيل منشئ$") and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n⏬| تم تنزيله من المنشئين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
------------------------------------------------------------------------
if text and text:match("^تنزيل منشئ @(.*)$") and BasicConstructor(msg) then
local username = text:match("^تنزيل منشئ @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Constructor'..msg.chat_id_, result.id_)
usertext = '\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(username or 'TuBakx')..')'
status  = '\n⏬| تم تنزيله من المنشئين'
texts = usertext..status
else
texts = '⚠️| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
------------------------------------------------------------------------
if text and text:match("^تنزيل منشئ (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^تنزيل منشئ (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n⏬| تم تنزيله من المنشئين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n🚹꒐ العضو :  '..userid..''
status  = '\n⏬| تم تنزيله من المنشئين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
------------------------------------------------------------------------
if text == 'مسح المدراء' and Constructor(msg) then
database:del(bot_id..'Manager'..msg.chat_id_)
texts = '✅| تم مسح المدراء في المجموعة'
send(msg.chat_id_, msg.id_, texts)
end
if text == ("المدراء") and Constructor(msg) then
local list = database:smembers(bot_id..'Manager'..msg.chat_id_)
t = "\n📋| قائمة المدراء \nٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "⚠️| لا يوجد مدراء"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع مدير") and msg.reply_to_message_id_ and Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n⏫| تم ترقيته مدير'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^رفع مدير @(.*)$") and Constructor(msg) then
local username = text:match("^رفع مدير @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Manager'..msg.chat_id_, result.id_)
usertext = '\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(username or 'TuBakx')..')'
status  = '\n⏫| تم ترقيته مدير'
texts = usertext..status
else
texts = '⚠️| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end 

if text and text:match("^رفع مدير (%d+)$") and Constructor(msg) then
local userid = text:match("^رفع مدير (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:sadd(bot_id..'Manager'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n⏫| تم ترقيته مدير'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n🚹꒐ العضو :  '..userid..''
status  = '\n⏫| تم ترقيته مدير'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end  
if text == ("تنزيل مدير") and msg.reply_to_message_id_ and Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n⏬| تم تنزيله من المدراء'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مدير @(.*)$") and Constructor(msg) then
local username = text:match("^تنزيل مدير @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
usertext = '\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(username or 'TuBakx')..')'
status  = '\n⏬| تم تنزيله من المدراء'
texts = usertext..status
else
texts = '⚠️| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مدير (%d+)$") and Constructor(msg) then
local userid = text:match("^تنزيل مدير (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Manager'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n⏬| تم تنزيله من المدراء'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n🚹꒐ العضو :  '..userid..''
status  = '\n⏬| تم تنزيله من المدراء'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end

if text == ("رفع مطور اساسي") and tonumber(msg.reply_to_message_id_) ~= 0 and SudoBot(msg) then
function Function_TuBacK(extra, result, success)
database:sadd(bot_id.."Dev:AhMd:2", result.sender_user_id_)
Reply_Status(msg,result.sender_user_id_,"reply","⏫| تم ترقيته مطور ثانوي في البوت")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, Function_TuBacK, nil)
return false 
end
if text and text:match("^رفع مطور اساسي @(.*)$") and SudoBot(msg) then
local username = text:match("^رفع مطور اساسي @(.*)$")
function Function_TuBacK(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id.."Dev:AhMd:2", result.id_)
Reply_Status(msg,result.id_,"reply","⏫| تم ترقيته مطور ثانوي في البوت")  
else
send(msg.chat_id_, msg.id_,"⚠️| لا يوجد حساب بهاذا المعرف")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, Function_TuBacK, nil)
return false 
end
if text and text:match("^رفع مطور اساسي (%d+)$") and SudoBot(msg) then
local userid = text:match("^رفع مطور اساسي (%d+)$")
database:sadd(bot_id.."Dev:AhMd:2", userid)
Reply_Status(msg,userid,"reply","⏫| تم ترقيته مطور ثانوي في البوت")  
return false 
end
if text == ("تنزيل مطور اساسي") and tonumber(msg.reply_to_message_id_) ~= 0 and SudoBot(msg) then
function Function_TuBacK(extra, result, success)
database:srem(bot_id.."Dev:AhMd:2", result.sender_user_id_)
Reply_Status(msg,result.sender_user_id_,"reply","⏬| تم تنزيله من المطور ثانويين")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, Function_TuBacK, nil)
return false 
end
if text and text:match("^تنزيل مطور اساسي @(.*)$") and SudoBot(msg) then
local username = text:match("^تنزيل مطور اساسي @(.*)$")
function Function_TuBacK(extra, result, success)
if result.id_ then
database:srem(bot_id.."Dev:AhMd:2", result.id_)
Reply_Status(msg,result.id_,"reply","⏬| تم تنزيله من المطور ثانويين")  
else
send(msg.chat_id_, msg.id_,"⚠️| لا يوجد حساب بهاذا المعرف")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, Function_TuBacK, nil)
return false
end  
if text and text:match("^تنزيل مطور اساسي (%d+)$") and SudoBot(msg) then
local userid = text:match("^تنزيل مطور اساسي (%d+)$")
database:srem(bot_id.."Dev:AhMd:2", userid)
Reply_Status(msg,userid,"reply","⏬| تم تنزيله من المطور ثانويين")  
return false 
end
if text == ("الاساسيين") and SudoBot(msg) then
local list = database:smembers(bot_id.."Dev:AhMd:2")
t = "\n📋| قائمة مطورين الاساسيين للبوت \nٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "⚠️| لا يوجد مطورين ثانويين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("مسح الاساسيين") and SudoBot(msg) then
database:del(bot_id.."Dev:AhMd:2")
send(msg.chat_id_, msg.id_, "\n✅| تم مسح قائمة المطورين الاساسيين  ")
end
------------------------------------------------------------------------
if text ==("رفع الادمنيه") and Manager(msg) then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local num2 = 0
local admins = data.members_
for i=0 , #admins do
if data.members_[i].bot_info_ == false and data.members_[i].status_.ID == "ChatMemberStatusEditor" then
database:sadd(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
num2 = num2 + 1
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,b) 
if b.username_ == true then
end
if b.first_name_ == false then
database:srem(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
end
end,nil)   
else
database:srem(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
end
end
if num2 == 0 then
send(msg.chat_id_, msg.id_,"⚠️| لا يوجد ادمنيه ليتم رفعهم") 
else
send(msg.chat_id_, msg.id_,"▶️| تمت ترقيه { "..num2.." } من الادمنيه") 
end
end,nil)   
end
if text == 'مسح الادمنيه' and Manager(msg) then
database:del(bot_id..'Mod:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '✅| تم مسح الادمنية من المجموعة')
end
if text == ("الادمنيه") and Manager(msg) then
local list = database:smembers(bot_id..'Mod:User'..msg.chat_id_)
t = "\n📋| قائمة الادمنيه \nٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "⚠️| لا يوجد ادمنيه"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع ادمن") and msg.reply_to_message_id_ and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'❎| تم تعطيل الرفع') 
return false
end
database:sadd(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n⏫| تم ترقيته ادمن في المجموعة'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع ادمن @(.*)$") and Manager(msg) then
local username = text:match("^رفع ادمن @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'❎| تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Mod:User'..msg.chat_id_, result.id_)
usertext = '\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(username or 'TuBakx')..')'
status  = '\n⏫| تم ترقيته ادمن في المجموعة'
texts = usertext..status
else
texts = '⚠️| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع ادمن (%d+)$") and Manager(msg) then
local userid = text:match("^رفع ادمن (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'❎| تم تعطيل الرفع') 
return false
end
database:sadd(bot_id..'Mod:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n⏫| تم ترقيته ادمن في المجموعة'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n🚹꒐ العضو :  '..userid..''
status  = '\n⏫| تم ترقيته ادمن في المجموعة'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل ادمن") and msg.reply_to_message_id_ and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n⏬| تم تنزيله من الادمنيه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل ادمن @(.*)$") and Manager(msg) then
local username = text:match("^تنزيل ادمن @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
usertext = '\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(username or 'TuBakx')..')'
status  = '\n⏬| تم تنزيله من الادمنيه'
texts = usertext..status
else
texts = '⚠️| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل ادمن (%d+)$") and Manager(msg) then
local userid = text:match("^تنزيل ادمن (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Mod:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n⏬| تم تنزيله من الادمنيه'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n🚹꒐ العضو :  '..userid..''
status  = '\n⏬| تم تنزيله من الادمنيه'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == 'مسح المنظفين' and BasicConstructor(msg) then
database:del(bot_id..'VlVlVI:MN:TF'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '🚮| تم مسح المنظفين')
end
if text == ("المنظفين") and BasicConstructor(msg) then
local list = database:smembers(bot_id..'VlVlVI:MN:TF'..msg.chat_id_)
t = "\n📋| قائمة المنظفين \n ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "⚠️| لا يوجد المنظفين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع منظف") and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not BasicConstructor(msg) then
send(msg.chat_id_, msg.id_,'❎| تم تعطيل الرفع') 
return false
end
database:sadd(bot_id..'VlVlVI:MN:TF'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n⏫| تم ترقيته منظف'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع منظف @(.*)$") and BasicConstructor(msg) then
local username = text:match("^رفع منظف @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not BasicConstructor(msg) then
send(msg.chat_id_, msg.id_,'❎| تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'VlVlVI:MN:TF'..msg.chat_id_, result.id_)
usertext = '\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(username or 'TuBakx')..')'
status  = '\n⏫| تم ترقيته منظف'
texts = usertext..status
else
texts = '⚠️| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع منظف (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^رفع منظف (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not BasicConstructor(msg) then
send(msg.chat_id_, msg.id_,'❎| تم تعطيل الرفع') 
return false
end
database:sadd(bot_id..'VlVlVI:MN:TF'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n⏫| تم ترقيته منظف'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n🚹꒐ العضو :  '..userid..''
status  = '\n⏫| تم ترقيته منظف'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل منظف") and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'VlVlVI:MN:TF'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n⏬| تم تنزيله من المنظفين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل منظف @(.*)$") and BasicConstructor(msg) then
local username = text:match("^تنزيل منظف @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'VlVlVI:MN:TF'..msg.chat_id_, result.id_)
usertext = '\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(username or 'TuBakx')..')'
status  = '\n⏬| تم تنزيله من المنظفين'
texts = usertext..status
else
texts = '⚠️| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل منظف (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^تنزيل منظف (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'VlVlVI:MN:TF'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n⏬| تم تنزيله من المنظفين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n🚹꒐ العضو :  '..userid..''
status  = '\n⏬| تم تنزيله من المنظفين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == ("طرد") and msg.reply_to_message_id_ ~=0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'⚠️| الطرد معطل في المجموعة') 
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠️| لا تسطيع طرد البوت ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⚠️| عذرا لا تستطيع طرد ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'⚠️| ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⚠️| البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
statusk  = '\n🚷| تم طرد من المجموعة'
send(msg.chat_id_, msg.id_, usertext..statusk)
end,nil)
chat_kick(result.chat_id_, result.sender_user_id_)
end,nil)   
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^طرد @(.*)$") and Mod(msg) then 
local username = text:match("^طرد @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'ℹ️| الطرد معطل في المجموعة') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠️| لا تسطيع طرد البوت ")
return false 
end
if Can_or_NotCan(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\nℹ️| عذرا لا تستطيع طرد ( '..Rutba(result.id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'⚠️| ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⚠️| البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
usertext = '\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(username or 'TuBakx')..')'
statusk  = '\n🚷| تم طرد من المجموعة'
texts = usertext..statusk
chat_kick(msg.chat_id_, result.id_)
send(msg.chat_id_, msg.id_, texts)
end,nil)   
end
else
send(msg.chat_id_, msg.id_, '⚠️| لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  

if text and text:match("^طرد (%d+)$") and Mod(msg) then 
local userid = text:match("^طرد (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا \n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'ℹ️| الطرد معطل في المجموعة') 
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠️| لا تسطيع طرد البوت ")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\nℹ️| عذرا لا تستطيع طرد ( '..Rutba(userid,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = userid, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,' ⚠️| ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⚠️| البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
chat_kick(msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
 usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
 statusk  = '\n🚷| تم طرد من المجموعة'
send(msg.chat_id_, msg.id_, usertext..statusk)
else
 usertext = '\n🚹꒐ العضو :  '..userid..''
 statusk  = '\n🚷| تم طرد من المجموعة'
send(msg.chat_id_, msg.id_, usertext..statusk)
end;end,nil)
end,nil)   
end
return false
end
------------------------------------------------------------------------
------------------------------------------------------------------------
if text == 'مسح المميزين' and Mod(msg) then
database:del(bot_id..'Special:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '✅| تم مسح المميزين من المجموعة')
end
if text == ("المميزين") and Mod(msg) then
local list = database:smembers(bot_id..'Special:User'..msg.chat_id_)
t = "\n📋| قائمة مميزين المجموعة \nٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "⚠️| لا يوجد مميزين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع مميز") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'❎| تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
local  statuss  = '\n⏫| تم ترقيته مميز في المجموعة'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع مميز @(.*)$") and Mod(msg) then
local username = text:match("^رفع مميز @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا \n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'❎| تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Special:User'..msg.chat_id_, result.id_)
usertext = '\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(username or 'TuBakx')..')'
local  statuss  = '\n⏫| تم ترقيته مميز في المجموعة'
texts = usertext..statuss
else
texts = '⚠️| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^رفع مميز (%d+)$") and Mod(msg) then
local userid = text:match("^رفع مميز (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا \n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'❎| تم تعطيل الرفع') 
return false
end
database:sadd(bot_id..'Special:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
local  statuss  = '\n⏫| تم ترقيته مميز في المجموعة'
send(msg.chat_id_, msg.id_, usertext..statuss)
else
usertext = '\n🚹꒐ العضو :  '..userid..''
local  statuss  = '\n⏫| تم ترقيته مميز في المجموعة'
send(msg.chat_id_, msg.id_, usertext..statuss)
end;end,nil)
return false
end

if (text == ("تنزيل مميز")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n⏬| تم تنزيله من المميزين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل مميز @(.*)$") and Mod(msg) then
local username = text:match("^تنزيل مميز @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا \n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
usertext = '\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(username or 'TuBakx')..')'
status  = '\n⏬| تم تنزيله من المميزين'
texts = usertext..status
else
texts = '⚠️| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل مميز (%d+)$") and Mod(msg) then
local userid = text:match("^تنزيل مميز (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا \n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Special:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n 🚹꒐ العضو : ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n⏬| تم تنزيله من المميزين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n🚹꒐ العضو :  '..userid..''
status  = '\n⏬| تم تنزيله من المميزين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end  
------------------------------------------------------------------------
if text == 'مسح المحظورين' and Mod(msg) then
database:del(bot_id..'Ban:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n🚮| تم مسح المحظورين')
end
if text == ("المحظورين") then
local list = database:smembers(bot_id..'Ban:User'..msg.chat_id_)
t = "\n📋| قائمة محظورين المجموعة \nٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "⚠️| لا يوجد محظورين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("حظر") and msg.reply_to_message_id_ ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا \n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,' ⚠️| تم تعطيل الحظر') 
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠️| لا تسطيع حظر البوت ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⚠️| عذرا لا تستطيع حظر ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.sender_user_id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,' ⚠️| ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⚠️| البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Ban:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n🚷| تم حظره من المجموعة'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
chat_kick(result.chat_id_, result.sender_user_id_)
end,nil)   
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if text and text:match("^حظر @(.*)$") and Mod(msg) then
local username = text:match("^حظر @(.*)$")
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'⚠️| تم تعطيل الحظر') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if Can_or_NotCan(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⚠️| عذرا لا تستطيع حظر ( '..Rutba(result.id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'⚠️| ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⚠️| البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Ban:User'..msg.chat_id_, result.id_)
usertext = '\n🚹| المستخدم : ['..result.title_..'](t.me/'..(username or 'GLOBLA')..')'
status  = '\n🚷| تم حظره من المجموعة'
texts = usertext..status
chat_kick(msg.chat_id_, result.id_)
send(msg.chat_id_, msg.id_, texts)
end,nil)   
end
else
send(msg.chat_id_, msg.id_, '⚠️| لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^حظر (%d+)$") and Mod(msg) then
local userid = text:match("^حظر (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'⚠️| تم تعطيل الحظر') 
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠️| لا تسطيع حظر البوت")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⚠️| عذرا لا تستطيع حظر ( '..Rutba(userid,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = userid, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,' ⚠️| ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⚠️| البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Ban:User'..msg.chat_id_, userid)
chat_kick(msg.chat_id_, userid)  
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n🚷| تم حظره من المجموعة'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n🚹꒐ العضو :  '..userid..''
status  = '\n🚷| تم حظره من المجموعة'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end,nil)   
end
return false
end
if text == ("الغاء حظر") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, '⚠️| انا لست محظورآ \n') 
return false 
end
database:srem(bot_id..'Ban:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n🚷| تم الغاء حظره من المجموعة'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.sender_user_id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
 
if text and text:match("^الغاء حظر @(.*)$") and Mod(msg) then
local username = text:match("^الغاء حظر @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, '⚠️| انا لست محظورآ \n') 
return false 
end
database:srem(bot_id..'Ban:User'..msg.chat_id_, result.id_)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
usertext = '\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(username or 'TuBakx')..')'
status  = '\n🚷| تم الغاء حظره من المجموعة'
texts = usertext..status
else
texts = '⚠️| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^الغاء حظر (%d+)$") and Mod(msg) then
local userid = text:match("^الغاء حظر (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if tonumber(userid) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, '⚠️| انا لست محظورآ \n') 
return false 
end
database:srem(bot_id..'Ban:User'..msg.chat_id_, userid)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = userid, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n🚷| تم الغاء حظره من المجموعة'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n🚹꒐ العضو :  '..userid..''
status  = '\n🚷| تم الغاء حظره من المجموعة'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == 'مسح المكتومين' and Mod(msg) then
database:del(bot_id..'Muted:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '✅| تم مسح المكتومين')
end
if text == ("المكتومين") and Mod(msg) then
local list = database:smembers(bot_id..'Muted:User'..msg.chat_id_)
t = "\n📋| قائمة المكتومين \nٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "⚠️| لا يوجد مكتومين"
end
send(msg.chat_id_, msg.id_, t)
end

if text == ("كتم") and msg.reply_to_message_id_ ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ⚠️| لا تسطيع كتم البوت")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n ⚠️| عذرا لا تستطيع كتم ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⚠️| البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Muted:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n🚷| تم كتمه في المجموعة'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^كتم @(.*)$") and Mod(msg) then
local username = text:match("^كتم @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⚠️| البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ⚠️| لا تسطيع كتم البوت")
return false 
end
if Can_or_NotCan(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n ⚠️| عذرا لا تستطيع كتم ( '..Rutba(result.id_,msg.chat_id_)..' )')
else
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Muted:User'..msg.chat_id_, result.id_)
usertext = '\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(username or 'TuBakx')..')'
status  = '\n🚷| تم كتمه في المجموعة'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
end
else
send(msg.chat_id_, msg.id_, '⚠️| لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match('^كتم (%d+) (.*)$') and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
local TextEnd = {string.match(text, "^(كتم) (%d+) (.*)$")}
function start_function(extra, result, success)
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n ⚠️| عذرا لا تستطيع كتم ( "..Rutba(result.sender_user_id_,msg.chat_id_).." )")
else
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n🚷| تم كتم لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'}'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_..'&until_date='..tonumber(msg.date_+Time))
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end


if text and text:match('^كتم (%d+) (.*) @(.*)$') and Mod(msg) then
local TextEnd = {string.match(text, "^(كتم) (%d+) (.*) @(.*)$")}
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n ⚠️| عذرا لا تستطيع كتم ( "..Rutba(result.id_,msg.chat_id_).." )")
else
usertext = '\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(username or 'TuBakx')..')'
status  = '\n🚷| تم كتم لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'}'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_..'&until_date='..tonumber(msg.date_+Time))
end
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = TextEnd[4]}, start_function, nil)
return false
end
if text and text:match("^كتم (%d+)$") and Mod(msg) then
local userid = text:match("^كتم (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ⚠️| لا تسطيع كتم البوت")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n ⚠️| عذرا لا تستطيع كتم ( '..Rutba(userid,msg.chat_id_)..' )')
else
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⚠️| البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Muted:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n🚷| تم كتمه في المجموعة'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n🚹꒐ العضو :  '..userid..''
status  = '\n🚷| تم كتمه في المجموعة'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
return false
end
if text == ("الغاء كتم") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Muted:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n🚷| تم الغاء كتمه من المجموعة'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^الغاء كتم @(.*)$") and Mod(msg) then
local username = text:match("^الغاء كتم @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Muted:User'..msg.chat_id_, result.id_)
usertext = '\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(username or 'TuBakx')..')'
status  = '\n🚷| تم الغاء كتمه من المجموعة'
texts = usertext..status
else
texts = '⚠️| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^الغاء كتم (%d+)$") and Mod(msg) then
local userid = text:match("^الغاء كتم (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Muted:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n🚷| تم الغاء كتمه من المجموعة'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n🚹꒐ العضو :  '..userid..''
status  = '\n🚷| تم الغاء كتمه من المجموعة'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end

if text == ("تقيد") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠️| لا تسطيع تقيد البوت ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, '\n⚠️| عذرا لا تستطيع تقيد ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n🚷| تم تقيده في المجموعة'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^تقيد @(.*)$") and Mod(msg) then
local username = text:match("^تقيد @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_,"⚠️| لا تسطيع تقيد البوت ")
return false 
end
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if Can_or_NotCan(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, '\n⚠️| عذرا لا تستطيع تقيد ( '..Rutba(result.id_,msg.chat_id_)..' )')
return false 
end      
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_)
 
usertext = '\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(username or 'TuBakx')..')'
status  = '\n🚷| تم تقيده في المجموعة'
texts = usertext..status
else
texts = '⚠️| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match('^تقيد (%d+) (.*)$') and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
local TextEnd = {string.match(text, "^(تقيد) (%d+) (.*)$")}
function start_function(extra, result, success)
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n⚠️| عذرا لا تستطيع تقيد ( "..Rutba(result.sender_user_id_,msg.chat_id_).." )")
else
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n🚷| تم تقيده في المجموعة لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'}'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_..'&until_date='..tonumber(msg.date_+Time))
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end


if text and text:match('^تقيد (%d+) (.*) @(.*)$') and Mod(msg) then
local TextEnd = {string.match(text, "^(تقيد) (%d+) (.*) @(.*)$")}
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n⚠️| عذرا لا تستطيع تقيد ( "..Rutba(result.id_,msg.chat_id_).." )")
else
usertext = '\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(username or 'TuBakx')..')'
status  = '\n🚷| تم تقيده في المجموعة لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'}'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_..'&until_date='..tonumber(msg.date_+Time))
end
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = TextEnd[4]}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^تقيد (%d+)$") and Mod(msg) then
local userid = text:match("^تقيد (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠️| لا تسطيع تقيد البوت ")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) then
send(msg.chat_id_, msg.id_, '\n⚠️| عذرا لا تستطيع تقيد ( '..Rutba(userid,msg.chat_id_)..' )')
else
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n🚷| تم تقيده في المجموعة'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n🚹꒐ العضو :  '..userid..''
status  = '\n🚷| تم تقيده في المجموعة'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
return false
end
------------------------------------------------------------------------
if text == ("الغاء تقيد") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" .. result.sender_user_id_ .. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n🚷| تم الغاء تقيده من المجموعة'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^الغاء تقيد @(.*)$") and Mod(msg) then
local username = text:match("^الغاء تقيد @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" .. result.id_ .. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
usertext = '\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(username or 'TuBakx')..')'
status  = '\n🚷| تم الغاء تقيده من المجموعة'
texts = usertext..status
else
texts = '⚠️| لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^الغاء تقيد (%d+)$") and Mod(msg) then
local userid = text:match("^الغاء تقيد (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..userid.. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n🚷| تم الغاء تقيده من المجموعة'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n🚹꒐ العضو :  '..userid..''
status  = '\n🚷| تم الغاء تقيده من المجموعة'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text and text:match('^رفع القيود @(.*)') and Manager(msg) then 
local username = text:match('^رفع القيود @(.*)') 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if DevTuBacK(msg) then
database:srem(bot_id..'GBan:User',result.id_)
database:srem(bot_id..'Ban:User'..msg.chat_id_,result.id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.id_)
database:srem(bot_id..'Gmute:User'..msg.chat_id_,result.id_)
usertext = '\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(username or 'TuBakx')..')'
status  = '\n🚷| تم الغاء جميع القيود'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
else
database:srem(bot_id..'Ban:User'..msg.chat_id_,result.id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.id_)
usertext = '\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(username or 'TuBakx')..')'
status  = '\n🚷| تم الغاء جميع القيود'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
end
else
Text = '⚠️| المعرف غلط'
send(msg.chat_id_, msg.id_,Text)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text == "رفع القيود" and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if DevTuBacK(msg) then
database:srem(bot_id..'GBan:User',result.sender_user_id_)
database:srem(bot_id..'Ban:User'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n🚷| تم الغاء جميع القيود'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
else
database:srem(bot_id..'Ban:User'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n🚷| تم الغاء جميع القيود'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text and text:match('^كشف القيود @(.*)') and Manager(msg) then 
local username = text:match('^كشف القيود @(.*)') 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if database:sismember(bot_id..'Muted:User'..msg.chat_id_,result.id_) then
Muted = 'مكتوم'
else
Muted = 'غير مكتوم'
end
if database:sismember(bot_id..'Ban:User'..msg.chat_id_,result.id_) then
Ban = 'محظور'
else
Ban = 'غير محظور'
end
if database:sismember(bot_id..'GBan:User',result.id_) then
GBan = 'محظور عام'
else
GBan = 'غير محظور عام'
end
Textt = "▶️| الحظر العام -› "..GBan.."\n🚸| الحظر -› "..Ban.."\n🚫| الكتم -› "..Muted..""
send(msg.chat_id_, msg.id_,Textt)
else
Text = '⚠️| المعرف غلط'
send(msg.chat_id_, msg.id_,Text)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end

if text == "كشف القيود" and Manager(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if database:sismember(bot_id..'Muted:User'..msg.chat_id_,result.sender_user_id_) then
Muted = 'مكتوم'
else
Muted = 'غير مكتوم'
end
if database:sismember(bot_id..'Ban:User'..msg.chat_id_,result.sender_user_id_) then
Ban = 'محظور'
else
Ban = 'غير محظور'
end
if database:sismember(bot_id..'GBan:User',result.sender_user_id_) then
GBan = 'محظور عام'
else
GBan = 'غير محظور عام'
end
if database:sismember(bot_id..'Gmute:User',result.sender_user_id_) then
Gmute = 'محظور عام'
else
Gmute = 'غير محظور عام'
end
Textt = "▶️| الحظر العام -› "..GBan.."\n▶️| الكتم العام -› "..Gmute.."\n🚸| الحظر -› "..Ban.."\n🚫| الكتم -› "..Muted..""
send(msg.chat_id_, msg.id_,Textt)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text == ("رفع مشرف") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⚠️| البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n▶️| الايدي :`'..result.sender_user_id_..'`\n⏫| تم رفعه مشرف في المجموعة '
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=True&can_restrict_members=false&can_pin_messages=True&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع مشرف @(.*)$") and Constructor(msg) then
local username = text:match("^رفع مشرف @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⚠️| البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
usertext = '\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(username or 'TuBakx')..')'
status  = '\n⏫| تم رفعه مشرف في المجموعة '
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=True&can_restrict_members=false&can_pin_messages=True&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, '⚠️| لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text == ("تنزيل مشرف") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⚠️| البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n▶️| الايدي : `'..result.sender_user_id_..'`\n⏬| تم تنزيله ادمن من المجموعة'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل مشرف @(.*)$") and Constructor(msg) then
local username = text:match("^تنزيل مشرف @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⚠️| البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
usertext = '\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(username or 'TuBakx')..')'
status  = '\n⏬| تم تنزيله ادمن من المجموعة'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, '⚠️| لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end


if text == ("رفع مشرف") and msg.reply_to_message_id_ ~= 0 and BasicConstructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⚠️| البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n▶️| الايدي : `'..result.sender_user_id_..'`\n⏫| تم رفعه مشرف بكل الصلاحيات'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=True&can_delete_messages=True&can_invite_users=True&can_restrict_members=True&can_pin_messages=True&can_promote_members=True")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع مشرف @(.*)$") and BasicConstructor(msg) then
local username = text:match("^رفع مشرف @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⚠️| البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
usertext = '\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(username or 'TuBakx')..')'
status  = '\n⏫| تم رفعه مشرف بكل الصلاحيات'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=True&can_delete_messages=True&can_invite_users=True&can_restrict_members=True&can_pin_messages=True&can_promote_members=True")
else
send(msg.chat_id_, msg.id_, 'ℹ️| لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text == ("تنزيل مشرف") and msg.reply_to_message_id_ ~= 0 and BasicConstructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⚠️| البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n▶️| الايدي :`'..result.sender_user_id_..'`\n⏬| تم تنزيله ادمن من الكروب بكل الصلاحيات'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل مشرف @(.*)$") and BasicConstructor(msg) then
local username = text:match("^تنزيل مشرف @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⚠️| البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
usertext = '\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(username or 'TuBakx')..')'
status  = '\n⏬| تم تنزيلة ادمن من المجموعة'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, '⚠️| لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text == 'عدادات المجموعه' and Mod(msg) then    
if database:get(bot_id..'lockpin'..msg.chat_id_) then    
lock_pin = '🔓'
else 
lock_pin = '🔐'    
end
if database:get(bot_id..'lock:tagservr'..msg.chat_id_) then    
lock_tagservr = '🔓'
else 
lock_tagservr = '🔐'    
end
if database:get(bot_id..'lock:text'..msg.chat_id_) then    
lock_text = '🔓'
else 
lock_text = '🔐'    
end
if database:get(bot_id.."lock:AddMempar"..msg.chat_id_) == 'kick' then
lock_add = '🔓'
else 
lock_add = '??'    
end    
if database:get(bot_id.."lock:Join"..msg.chat_id_) == 'kick' then
lock_join = '🔓'
else 
lock_join = '🔐'    
end    
if database:get(bot_id..'lock:edit'..msg.chat_id_) then    
lock_edit = '🔓'
else 
lock_edit = '🔐'    
end
print(welcome)
if database:get(bot_id..'Get:Welcome:Group'..msg.chat_id_) then
welcome = '🔓'
else 
welcome = '🔐'    
end
if database:get(bot_id..'lock:edit'..msg.chat_id_) then    
lock_edit_med = '🔓'
else 
lock_edit_med = '🔐'    
end
if database:hget(bot_id.."flooding:settings:"..msg.chat_id_, "flood") == "kick" then     
flood = 'بالطرد'     
elseif database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") == "keed" then     
flood = 'بالتقيد'     
elseif database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") == "mute" then     
flood = 'بالكتم'           
elseif database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") == "del" then     
flood = 'بالمسح'           
else     
flood = '🔐'     
end
if database:get(bot_id.."lock:Photo"..msg.chat_id_) == "del" then
lock_photo = '🔓' 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ked" then 
lock_photo = 'بالتقيد'   
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ktm" then 
lock_photo = 'بالكتم'    
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "kick" then 
lock_photo = 'بالطرد'   
else
lock_photo = '🔐'   
end    
if database:get(bot_id.."lock:Contact"..msg.chat_id_) == "del" then
lock_phon = '🔓' 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ked" then 
lock_phon = 'بالتقيد'    
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ktm" then 
lock_phon = 'بالكتم'    
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "kick" then 
lock_phon = 'بالطرد'    
else
lock_phon = '🔐'    
end    
if database:get(bot_id.."lock:Link"..msg.chat_id_) == "del" then
lock_links = '🔓'
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ked" then
lock_links = 'بالتقيد'    
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ktm" then
lock_links = 'بالكتم'    
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "kick" then
lock_links = 'بالطرد'    
else
lock_links = '🔐'    
end
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "del" then
lock_cmds = '🔓'
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ked" then
lock_cmds = 'بالتقيد'    
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ktm" then
lock_cmds = 'بالكتم'   
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "kick" then
lock_cmds = 'بالطرد'    
else
lock_cmds = '🔐'    
end
if database:get(bot_id.."lock:user:name"..msg.chat_id_) == "del" then
lock_user = '🔓'
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ked" then
lock_user = 'بالتقيد'    
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ktm" then
lock_user = 'بالكتم'    
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "kick" then
lock_user = 'بالطرد'    
else
lock_user = '🔐'    
end
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "del" then
lock_hash = '🔓'
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ked" then 
lock_hash = 'بالتقيد'    
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ktm" then 
lock_hash = 'بالكتم'    
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "kick" then 
lock_hash = 'بالطرد'    
else
lock_hash = '🔐'    
end
if database:get(bot_id.."lock:vico"..msg.chat_id_) == "del" then
lock_muse = '🔓'
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ked" then 
lock_muse = 'بالتقيد'    
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ktm" then 
lock_muse = 'بالكتم'    
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "kick" then 
lock_muse = 'بالطرد'    
else
lock_muse = '🔐'    
end 
if database:get(bot_id.."lock:Video"..msg.chat_id_) == "del" then
lock_ved = '🔓'
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ked" then 
lock_ved = 'بالتقيد'    
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ktm" then 
lock_ved = 'بالكتم'    
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "kick" then 
lock_ved = 'بالطرد'    
else
lock_ved = '🔐'    
end
if database:get(bot_id.."lock:Animation"..msg.chat_id_) == "del" then
lock_gif = '🔓'
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ked" then 
lock_gif = 'بالتقيد'    
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ktm" then 
lock_gif = 'بالكتم'    
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "kick" then 
lock_gif = 'بالطرد'    
else
lock_gif = '🔐'    
end
if database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "del" then
lock_ste = '🔓'
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ked" then 
lock_ste = 'بالتقيد'    
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ktm" then 
lock_ste = 'بالكتم'    
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "kick" then 
lock_ste = 'بالطرد'    
else
lock_ste = '🔐'    
end
if database:get(bot_id.."lock:geam"..msg.chat_id_) == "del" then
lock_geam = '🔓'
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ked" then 
lock_geam = 'بالتقيد'    
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ktm" then 
lock_geam = 'بالكتم'    
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "kick" then 
lock_geam = 'بالطرد'    
else
lock_geam = '🔐'    
end    
if database:get(bot_id.."lock:vico"..msg.chat_id_) == "del" then
lock_vico = '🔓'
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ked" then 
lock_vico = 'بالتقيد'    
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ktm" then 
lock_vico = 'بالكتم'    
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "kick" then 
lock_vico = 'بالطرد'    
else
lock_vico = '🔐'    
end    
if database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "del" then
lock_inlin = '🔓'
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ked" then 
lock_inlin = 'بالتقيد'
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ktm" then 
lock_inlin = 'بالكتم'    
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "kick" then 
lock_inlin = 'بالطرد'
else
lock_inlin = '🔐'
end
if database:get(bot_id.."lock:forward"..msg.chat_id_) == "del" then
lock_fwd = '🔓'
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ked" then 
lock_fwd = 'بالتقيد'    
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ktm" then 
lock_fwd = 'بالكتم'    
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "kick" then 
lock_fwd = 'بالطرد'    
else
lock_fwd = '🔐'    
end    
if database:get(bot_id.."lock:Document"..msg.chat_id_) == "del" then
lock_file = '🔓'
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ked" then 
lock_file = 'بالتقيد'    
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ktm" then 
lock_file = 'بالكتم'    
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "kick" then 
lock_file = 'بالطرد'    
else
lock_file = '🔐'    
end    
if database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "del" then
lock_self = '🔓'
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ked" then 
lock_self = 'بالتقيد'    
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ktm" then 
lock_self = 'بالكتم'    
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "kick" then 
lock_self = 'بالطرد'    
else
lock_self = '🔐'    
end
if database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) == 'del' then
lock_bots = '🔓'
elseif database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) == 'ked' then
lock_bots = 'بالتقيد'   
elseif database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) == 'kick' then
lock_bots = 'بالطرد'    
else
lock_bots = '🔐'    
end
if database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "del" then
lock_mark = '🔓'
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ked" then 
lock_mark = 'بالتقيد'    
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ktm" then 
lock_mark = 'بالكتم'    
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "kick" then 
lock_mark = 'بالطرد'    
else
lock_mark = '🔐'    
end
if database:get(bot_id.."lock:Spam"..msg.chat_id_) == "del" then    
lock_spam = '🔓'
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ked" then 
lock_spam = 'بالتقيد'    
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ktm" then 
lock_spam = 'بالكتم'    
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "kick" then 
lock_spam = 'بالطرد'    
else
lock_spam = '🔐'    
end        
if not database:get(bot_id..'Reply:Manager'..msg.chat_id_) then
rdmder = '🔓'
else
rdmder = '🔐'
end
if not database:get(bot_id..'Reply:Sudo'..msg.chat_id_) then
rdsudo = '🔓'
else
rdsudo = '🔐'
end
if not database:get(bot_id..'Bot:Id'..msg.chat_id_)  then
idgp = '🔓'
else
idgp = '🔐'
end
if not database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_) then
idph = '🔓'
else
idph = '🔐'
end
if not database:get(bot_id..'Lock:kick'..msg.chat_id_)  then
setadd = '🔓'
else
setadd = '🔐'
end
if not database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_)  then
banm = '🔓'
else
banm = '🔐'
end
if not database:get(bot_id..'Added:Me'..msg.chat_id_) then
addme = '🔓'
else
addme = '🔐'
end
if not database:get(bot_id..'Seh:User'..msg.chat_id_) then
sehuser = '🔓'
else
sehuser = '🔐'
end
if not database:get(bot_id..'Cick:Me'..msg.chat_id_) then
kickme = '🔓'
else
kickme = '🔐'
end
NUM_MSG_MAX = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") or 0
local text = 
'\n⚙️┇𝙶𝚁𝙾𝚄𝙿 𝚂𝙴𝚃𝚃𝙸𝙽𝙶𝚂'..
'\nٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯'..
'\n🔽| اعدادات المجموعة كتالي: ↑↓'..
'\nءٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯'..
'\n • علامة ال {🔓} تعني مفعل'..
'\n •علامة ال {🔐} تعني معطل'..
'\nءٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯'..
'\n •  الروابط -› { '..lock_links..
' }\n'..' •  المعرفات -› { '..lock_user..
' }\n'..' •  التاك -› { '..lock_hash..
' }\n'..' •  البوتات -› { '..lock_bots..
' }\n'..' •  التوجيه -› { '..lock_fwd..
' }\n'..' •  التثبيت -› { '..lock_pin..
' }\n'..' •  الاشعارات -› { '..lock_tagservr..
' }\n'..' •  الماركدون -› { '..lock_mark..
' }\n'..' •  التعديل -› { '..lock_edit..
' }\n'..' •  تعديل الميديا -› { '..lock_edit_med..
' }\nءٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯'..
'\n'..' •  الكلايش -› { '..lock_spam..
' }\n'..' •  الكيبورد -› { '..lock_inlin..
' }\n'..' •  الاغاني -› { '..lock_vico..
' }\n'..' •  المتحركه -› { '..lock_gif..
' }\n'..' •  الملفات -› { '..lock_file..
' }\n'..' •  الدردشه -› { '..lock_text..
' }\n'..' •   الفيديو -› { '..lock_ved..
' }\n'..' •   الصور -› { '..lock_photo..
' }\nءٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯'..
'\n'..' •   الصوت -› { '..lock_muse..
' }\n'..' •  الملصقات -› { '..lock_ste..
' }\n'..' •  الجهات -› { '..lock_phon..
' }\n'..' •  الدخول -› { '..lock_join..
' }\n'..' •  الاضافه -› { '..lock_add..
' }\n'..' •  السيلفي -› { '..lock_self..
' }\n'..' •  الالعاب -› { '..lock_geam..
' }\n'..' •  التكرار -› { '..flood..
' }\n'..' •  الترحيب -› { '..welcome..
' }\n'..' •  عدد التكرار -› { '..NUM_MSG_MAX..
' }\nءٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯'..
'\n •  علامة ال {🔓} تعني مفعل'..
'\n •  علامة ال {🔐} تعني معطل'..
'\nءٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯'..
'\n'..' •  امر صيح -› { '..kickme..
' }\n'..' •  امر اطردني -› { '..sehuser..
' }\n'..' •  امر منو ضافني -› { '..addme..
' }\n'..' •  ردود المدير -› { '..rdmder..
' }\n'..' •  ردود المطور -› { '..rdsudo..
' }\n'..' •  الايدي -› { '..idgp..
' }\n'..' •  الايدي بالصوره -› { '..idph..
' }\n'..' •  الرفع -› { '..setadd..
' }\n'..'•  الحظر -› { '..banm..' }\n\nٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯\n🚹| [Source Tubak .](t.me/TuBakx) \n'
send(msg.chat_id_, msg.id_,text)     
end
if text ==('تثبيت') and msg.reply_to_message_id_ ~= 0 and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا \n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'lock:pin',msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_,"⚠️| عذرآ تم قفل التثبيت")  
return false  
end
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.reply_to_message_id_,disable_notification_ = 1},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_,"✅| تم تثبيت الرساله")   
database:set(bot_id..'Pin:Id:Msg'..msg.chat_id_,msg.reply_to_message_id_)
elseif data.code_ == 6 then
send(msg.chat_id_,msg.id_,"⚠️| انا لست ادمن هنا يرجى ترقيتي ادمن ثم اعد المحاوله")  
elseif data.message_ == "CHAT_NOT_MODIFIED" then
send(msg.chat_id_,msg.id_,"🚹| لا توجد رساله مثبته")  
elseif data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"⚠️| ليست لدي صلاحية التثبيت يرجى التحقق من الصلاحيات")  
end
end,nil) 
end
if text == 'الغاء التثبيت' and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'lock:pin',msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_,"⚠️| عذرآ تم قفل الثبيت")  
return false  
end
tdcli_function({ID="UnpinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100','')},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_,"✅| تم الغاء تثبيت الرساله")   
database:del(bot_id..'Pin:Id:Msg'..msg.chat_id_)
elseif data.code_ == 6 then
send(msg.chat_id_,msg.id_,"⚠️| انا لست ادمن هنا يرجى ترقيتي ادمن ثم اعد المحاوله")  
elseif data.message_ == "CHAT_NOT_MODIFIED" then
send(msg.chat_id_,msg.id_,"🚹| لا توجد رساله مثبته")  
elseif data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"⚠️| ليست لدي صلاحية التثبيت يرجى التحقق من الصلاحيات")  
end
end,nil)
end
if text == 'الغاء تثبيت الكل' and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'lock:pin',msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_,"⚠️| عذرآ تم قفل الثبيت")  
return false  
end
tdcli_function({ID="UnpinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100','')},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_,"✅| تم الغاء تثبيت الكل")   
https.request('https://api.telegram.org/bot'..token..'/unpinAllChatMessages?chat_id='..msg.chat_id_)
database:del(bot_id..'Pin:Id:Msg'..msg.chat_id_)
elseif data.code_ == 6 then
send(msg.chat_id_,msg.id_,"⚠️| انا لست ادمن هنا يرجى ترقيتي ادمن ثم اعد المحاوله")  
elseif data.message_ == "CHAT_NOT_MODIFIED" then
send(msg.chat_id_,msg.id_,"🚹| لا توجد رساله مثبته")  
elseif data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"⚠️| ليست لدي صلاحية التثبيت يرجى التحقق من الصلاحيات")  
end
end,nil)
end
if text and text:match('^ضع تكرار (%d+)$') and Mod(msg) then   
local Num = text:match('ضع تكرار (.*)')
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"floodmax" ,Num) 
send(msg.chat_id_, msg.id_,'✅| تم وضع عدد التكرار ('..Num..')')  
end 
if text and text:match('^ضع زمن التكرار (%d+)$') and Mod(msg) then   
local Num = text:match('^ضع زمن التكرار (%d+)$')
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"floodtime" ,Num) 
send(msg.chat_id_, msg.id_,'✅| تم وضع زمن التكرار ('..Num..')') 
end
if text == "ضع رابط" or text == 'وضع رابط' then
if msg.reply_to_message_id_ == 0  and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_,msg.id_,"↪️| حسنآ ارسل اليه الرابط الان")
database:setex(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_,120,true) 
return false
end
end
if text == "تفعيل رابط" or text == 'تفعيل الرابط' then
if Mod(msg) then  
database:set(bot_id.."Link_Group:status"..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,"✅| تم تفعيل الرابط") 
return false  
end
end
if text == "تعطيل رابط" or text == 'تعطيل الرابط' then
if Mod(msg) then  
database:del(bot_id.."Link_Group:status"..msg.chat_id_) 
send(msg.chat_id_, msg.id_,"❎| تم تعطيل الرابط") 
return false end
end

if text == 'المطور' or text == 'مطور' then
local TEXT_SUDO = database:get(bot_id..'TEXT_SUDO')
if TEXT_SUDO then 
send(msg.chat_id_, msg.id_,TEXT_SUDO)
else
tdcli_function ({ID = "GetUser",user_id_ = SUDO},function(arg,result) 
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
sendText(msg.chat_id_,Name,msg.id_/2097152/0.5,'md')
end,nil)
end
end
if text == "تفعيل صورتي" or text == 'تفعيل الصوره' then
if Constructor(msg) then  
database:set(bot_id.."my_photo:status"..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,"✅| تم تفعيل الصورة") 
return false  
end
end
if text == "تعطيل الصوره" or text == 'تعطيل صورتي' then
if Constructor(msg) then  
database:del(bot_id.."my_photo:status"..msg.chat_id_) 
send(msg.chat_id_, msg.id_,"⚠️| تم تعطيل الصوره") 
return false end
end
if text == "الرابط" then 
local url,res = https.request('https://anashtick.ml/TuBak.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.TuBak ~= true then
local inline = {{{text="اضغط هنا للشتراك 🚹",url="https://t.me/TuBakx"}}}
SendInline(msg.chat_id_,'عذراً عليك الاشتراك في [. Team TuBak](t.me/TuBaKx) \nليمكنك استخدام البوت بشكل كامل',nil,inline)
return false 
end
local status_Link = database:get(bot_id.."Link_Group:status"..msg.chat_id_)
if not status_Link then
send(msg.chat_id_, msg.id_,"❎| عذراً الرابط معطل") 
return false  
end
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,ta) 
local link = database:get(bot_id.."Private:Group:Link"..msg.chat_id_)            
if link then                              
send(msg.chat_id_,msg.id_,'🖇️| رابط المجموعة : \n ['..ta.title_..']('..link..')')                          
else                
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
linkgp = '🖇️| رابط المجموعة : \n ['..ta.title_..']('..linkgpp.result..')'
else
linkgp = '⚠️| لا يوجد رابط ارسل ضع رابط'
end  
send(msg.chat_id_, msg.id_,linkgp)              
end      
end,nil)
end
if text == 'مسح الرابط' or text == 'حذف الرابط' then
if Mod(msg) then     
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_,msg.id_,"✅| تم مسح الرابط")           
database:del(bot_id.."Private:Group:Link"..msg.chat_id_) 
return false      
end
end
if text and text:match("^ضع صوره") and Mod(msg) and msg.reply_to_message_id_ == 0 then  
database:set(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_,true) 
send(msg.chat_id_, msg.id_,'↪️| ارسل لي الصوره') 
return false
end
if text == "حذف الصوره" or text == "مسح الصوره" then 
if Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
https.request('https://api.telegram.org/bot'..token..'/deleteChatPhoto?chat_id='..msg.chat_id_) 
send(msg.chat_id_, msg.id_,'✅| تم حذف صورة المجموعة') 
end
return false  
end
if text == 'ضع وصف' or text == 'وضع وصف' then  
if Mod(msg) then
database:setex(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_,'↪️| ارسل الان الوصف')
end
return false  
end
if text == 'ضع ترحيب' or text == 'وضع ترحيب' then  
if Mod(msg) then
database:setex(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
t  = ' ↪️| ارسل لي الترحيب الان'
tt = '\n\n⏬| تستطيع اضافة مايلي !\n• دالة عرض الاسم -›{`name`}\n• دالة عرض المعرف -›{`user`}'
send(msg.chat_id_, msg.id_,t..tt) 
end
return false  
end
if text == 'الترحيب' and Mod(msg) then 
local GetWelcomeGroup = database:get(bot_id..'Get:Welcome:Group'..msg.chat_id_)  
if GetWelcomeGroup then 
GetWelcome = GetWelcomeGroup
else 
GetWelcome = '⚠️| لايوجد ترحيب في المجموعة'
end 
send(msg.chat_id_, msg.id_,'['..GetWelcome..']') 
return false  
end
if text == 'تفعيل الترحيب' and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id..'Chek:Welcome'..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,'✅| تم تفعيل ترحيب في المجموعة') 
return false  
end
if text == 'تعطيل الترحيب' and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:del(bot_id..'Chek:Welcome'..msg.chat_id_) 
send(msg.chat_id_, msg.id_,'❎| تم تعطيل ترحيب في المجموعة') 
return false  
end
if text == 'مسح الترحيب' or text == 'حذف الترحيب' then 
if Mod(msg) then
database:del(bot_id..'Get:Welcome:Group'..msg.chat_id_) 
send(msg.chat_id_, msg.id_,'✅| تم حذف ترحيب المجموعه') 
end
end
if text and text == "منع" and msg.reply_to_message_id_ == 0 and Manager(msg)  then       
send(msg.chat_id_, msg.id_,"↪️| حسناً ارسل الكلمة لمنعها")  
database:set(bot_id.."TuBacK1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_,"rep")  
return false  
end    
if text then   
local tsssst = database:get(bot_id.."TuBacK1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if tsssst == "rep" then   
send(msg.chat_id_, msg.id_,"♨️| تم حفظ الكلمه الممنوعة \n🔽| ارسل التحذير عند ارسال الكلمه")  
database:set(bot_id.."TuBacK1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_,"repp")  
database:set(bot_id.."TuBacK1:filtr1:add:reply2"..msg.sender_user_id_..msg.chat_id_, text)  
database:sadd(bot_id.."TuBacK1:List:Filter"..msg.chat_id_,text)  
return false  end  
end
if text then  
local test = database:get(bot_id.."TuBacK1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if test == "repp" then  
send(msg.chat_id_, msg.id_,"✅| تم منع الكلمه مع التحذير")  
database:del(bot_id.."TuBacK1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
local test = database:get(bot_id.."TuBacK1:filtr1:add:reply2"..msg.sender_user_id_..msg.chat_id_)  
if text then   
database:set(bot_id.."TuBacK1:Add:Filter:Rp2"..test..msg.chat_id_, text)  
end  
database:del(bot_id.."TuBacK1:filtr1:add:reply2"..msg.sender_user_id_..msg.chat_id_)  
return false  end  
end

if text == "الغاء منع" and msg.reply_to_message_id_ == 0 and Manager(msg) then    
send(msg.chat_id_, msg.id_,"↪️| ارسل الكلمه لمنعها الان")  
database:set(bot_id.."TuBacK1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_,"reppp")  
return false  end
if text then 
local test = database:get(bot_id.."TuBacK1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if test and test == "reppp" then   
send(msg.chat_id_, msg.id_,"✅| تم الغاء منعها من القائمة")  
database:del(bot_id.."TuBacK1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
database:del(bot_id.."TuBacK1:Add:Filter:Rp2"..text..msg.chat_id_)  
database:srem(bot_id.."TuBacK1:List:Filter"..msg.chat_id_,text)  
return false  end  
end


if text == 'منع' and tonumber(msg.reply_to_message_id_) > 0 and Manager(msg) then     
function cb(a,b,c) 
textt = '✅| تم منع '
if b.content_.sticker_ then
local idsticker = b.content_.sticker_.set_id_
database:sadd(bot_id.."filtersteckr"..msg.chat_id_,idsticker)
text = 'الملصق'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح لن يتم ارسالها مجددا')  
return false
end
if b.content_.ID == "MessagePhoto" then
local photo = b.content_.photo_.id_
database:sadd(bot_id.."filterphoto"..msg.chat_id_,photo)
text = 'الصوره'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح لن يتم ارسالها مجددا')  
return false
end
if b.content_.animation_.animation_ then
local idanimation = b.content_.animation_.animation_.persistent_id_
database:sadd(bot_id.."filteranimation"..msg.chat_id_,idanimation)
text = 'المتحركه'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح لن يتم ارسالها مجددا')  
return false
end
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, cb, nil)
end
if text == 'الغاء منع' and tonumber(msg.reply_to_message_id_) > 0 and Manager(msg) then     
function cb(a,b,c) 
textt = '✅| تم الغاء منع '
if b.content_.sticker_ then
local idsticker = b.content_.sticker_.set_id_
database:srem(bot_id.."filtersteckr"..msg.chat_id_,idsticker)
text = 'الملصق'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح يمكنهم الارسال الان')  
return false
end
if b.content_.ID == "MessagePhoto" then
local photo = b.content_.photo_.id_
database:srem(bot_id.."filterphoto"..msg.chat_id_,photo)
text = 'الصوره'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح يمكنهم الارسال الان')  
return false
end
if b.content_.animation_.animation_ then
local idanimation = b.content_.animation_.animation_.persistent_id_
database:srem(bot_id.."filteranimation"..msg.chat_id_,idanimation)
text = 'المتحركه'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح يمكنهم الارسال الان')  
return false
end
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, cb, nil)
end

if text == "مسح قائمه المنع"and Manager(msg) then   
local list = database:smembers(bot_id.."TuBacK1:List:Filter"..msg.chat_id_)  
for k,v in pairs(list) do  
database:del(bot_id.."TuBacK1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
database:del(bot_id.."TuBacK1:Add:Filter:Rp2"..v..msg.chat_id_)  
database:srem(bot_id.."TuBacK1:List:Filter"..msg.chat_id_,v)  
end  
send(msg.chat_id_, msg.id_,"✅| تم مسح قائمه المنع")  
end

if text == "قائمه المنع" and Manager(msg) then   
database:set(bot_id.."TuBacK:Filter:msg",msg.chat_id_)
tdcli_function ({ID = "GetUser",user_id_ = bot_id},function(arg,data) 
local Text ='⌔︙قائمه الممنوعات'
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'صور', url="https://t.me/"..data.username_.."?start=ph"..msg.chat_id_},{text = 'كلمات', url="https://t.me/"..data.username_.."?start=msg"..msg.chat_id_}},
{{text = 'متحركات', url="https://t.me/"..data.username_.."?start=gif"..msg.chat_id_},{text = 'ملصقات', url="https://t.me/"..data.username_.."?start=Sti"..msg.chat_id_}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end,nil)
end


if text == "قائمه المنع" and Manager(msg) then   
local list = database:smembers(bot_id.."TuBacK1:List:Filter"..msg.chat_id_)  
t = "\n📋| قائمة المنع \nٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯\n"
for k,v in pairs(list) do  
local TuBacK_Msg = database:get(bot_id.."TuBacK1:Add:Filter:Rp2"..v..msg.chat_id_)   
t = t..""..k.."- "..v.." -› {"..TuBacK_Msg.."}\n"    
end  
if #list == 0 then  
t = "⚠️| لا يوجد كلمات ممنوعه"  
end  
send(msg.chat_id_, msg.id_,t)  
end  

if text == 'مسح قائمه منع المتحركات' and Manager(msg) then     
database:del(bot_id.."filteranimation"..msg.chat_id_)
send(msg.chat_id_, msg.id_,'✅| تم مسح قائمه منع المتحركات')  
end
if text == 'مسح قائمه منع الصور' and Manager(msg) then     
database:del(bot_id.."filterphoto"..msg.chat_id_)
send(msg.chat_id_, msg.id_,'✅| تم مسح قائمه منع الصور')  
end
if text == 'مسح قائمه منع الملصقات' and Manager(msg) then     
database:del(bot_id.."filtersteckr"..msg.chat_id_)
send(msg.chat_id_, msg.id_,'✅| تم مسح قائمه منع الملصقات')  
end
------------------

if text == 'مسح كليشه المطور' and DevTuBacK(msg) then
database:del(bot_id..'TEXT_SUDO')
send(msg.chat_id_, msg.id_,'✅| تم مسح كليشه المطور')
end
if text == 'ضع كليشه المطور' and DevTuBacK(msg) then
database:set(bot_id..'Set:TEXT_SUDO'..msg.chat_id_..':'..msg.sender_user_id_,true)
send(msg.chat_id_,msg.id_,'↪️| حسناً ارسل الكليشه الان')
return false
end
if text and database:get(bot_id..'Set:TEXT_SUDO'..msg.chat_id_..':'..msg.sender_user_id_) then
if text == 'الغاء' then 
database:del(bot_id..'Set:TEXT_SUDO'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_,msg.id_,'❎| تم الغاء حفظ كليشة المطور')
return false
end
database:set(bot_id..'TEXT_SUDO',text)
database:del(bot_id..'Set:TEXT_SUDO'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_,msg.id_,'✅| تم حفظ كليشة المطور')
return false
end
-----------------
if text == 'تعين الايدي' and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_,240,true)  
local Text= [[
↪️| ارسل كليشة الايدي الان :

• `#rdphoto` -› تعليق الصوره
• `#username` -› اسم 
• `#msgs` -› عدد رسائل 
• `#photos` -› عدد صور 
• `#id` -› ايدي 
• `#auto` -› تفاعل 
• `#stast` -› موقع  
• `#edit` -› السحكات
• `#game` -› النقاط
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false  
end 

if text == 'حذف الايدي' or text == 'مسح الايدي' then
if Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا \n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:del(bot_id.."KLISH:ID"..msg.chat_id_)
send(msg.chat_id_, msg.id_, '🚮| تم حذف كليشة الايدي')
end
return false  
end 

if database:get(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_,"❎| تم الغاء تعين الايدي") 
database:del(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
database:del(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_) 
local CHENGER_ID = text:match("(.*)")  
database:set(bot_id.."KLISH:ID"..msg.chat_id_,CHENGER_ID)
send(msg.chat_id_, msg.id_,'✅| تم تعين الايدي في المجموعة')    
end

if text == 'طرد البوتات' and Mod(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
tdcli_function ({ ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah)  
local admins = tah.members_  
local x = 0
local c = 0
for i=0 , #admins do 
if tah.members_[i].status_.ID == "ChatMemberStatusEditor" then  
x = x + 1 
end
if tonumber(admins[i].user_id_) ~= tonumber(bot_id) then
chat_kick(msg.chat_id_,admins[i].user_id_)
end
c = c + 1
end     
if (c - x) == 0 then
send(msg.chat_id_, msg.id_, "⚠️| لا توجد بوتات في المجموعة")
else
local t = '🔢| عدد البوتات هنا >> {'..c..'}\n♿| عدد البوتات التي هي ادمن >> {'..x..'}\n🚼| تم طرد >> {'..(c - x)..'} من البوتات'
send(msg.chat_id_, msg.id_,t) 
end 
end,nil)  
end   
end
if text == ("كشف البوتات") and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا \n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
tdcli_function ({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(extra,result,success)
local admins = result.members_  
text = "\n📋| قائمة البوتات الموجوده \nٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯\n"
local n = 0
local t = 0
for i=0 , #admins do 
n = (n + 1)
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_
},function(arg,ta) 
if result.members_[i].status_.ID == "ChatMemberStatusMember" then  
tr = ''
elseif result.members_[i].status_.ID == "ChatMemberStatusEditor" then  
t = t + 1
tr = ' {★}'
end
text = text..">> [@"..ta.username_..']'..tr.."\n"
if #admins == 0 then
send(msg.chat_id_, msg.id_, "ℹ️| لا توجد بوتات في المجموعة")
return false 
end
if #admins == i then 
local a = '\nٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯\n🔢| عدد البوتات التي هنا -› {'..n..'} بوت\n'
local f = '📫| عدد البوتات التي هي ادمن -› {'..t..'}\n📌| ملاحضه علامة ال (✯) تعني ان البوت ادمن \n'
send(msg.chat_id_, msg.id_, text..a..f)
end
end,nil)
end
end,nil)
end

if database:get(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_, "❎| تم الغاء حفظ القوانين") 
database:del(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
return false  
end 
database:set(bot_id.."Set:Rules:Group" .. msg.chat_id_,text) 
send(msg.chat_id_, msg.id_,"✅| تم حفظ قوانين المجموعة") 
database:del(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
end  

if text == 'ضع قوانين' or text == 'وضع قوانين' then 
if Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا \n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_,msg.id_,"↪️| ارسل لي القوانين الان")  
end
end
if text == 'مسح القوانين' or text == 'حذف القوانين' then  
if Mod(msg) then
send(msg.chat_id_, msg.id_,"🚮| تم ازالة قوانين المجموعة")  
database:del(bot_id.."Set:Rules:Group"..msg.chat_id_) 
end
end
if text == 'القوانين' then 
local Set_Rules = database:get(bot_id.."Set:Rules:Group" .. msg.chat_id_)   
if Set_Rules then     
send(msg.chat_id_,msg.id_, Set_Rules)   
else      
send(msg.chat_id_, msg.id_,"⚠️| لا توجد قوانين")   
end    
end
if text == 'قفل التفليش' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id..'lock:tagrvrbot'..msg.chat_id_,true)   
list ={"lock:Bot:kick","lock:user:name","lock:Link","lock:forward","lock:Sticker","lock:Animation","lock:Video","lock:Fshar","lock:Fars","Bot:Id:Photo","lock:Audio","lock:vico","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:set(bot_id..lock..msg.chat_id_,'del')    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n❎| تـم قفـل التفليش ')  
end,nil)   
end
if text == 'فتح التفليش' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id..'lock:tagrvrbot'..msg.chat_id_)   
list ={"lock:Bot:kick","lock:user:name","lock:Link","lock:forward","lock:Sticker","lock:Animation","lock:Video","lock:Fshar","lock:Fars","Bot:Id:Photo","lock:Audio","lock:vico","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:del(bot_id..lock..msg.chat_id_)    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'◀️꒐ بواسطه ⌁  ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'TuBakx')..') \n✅| تـم فـتح التفليش ')  
end,nil)   
end
if text == 'طرد المحذوفين' or text == 'مسح المحذوفين' then  
if Mod(msg) then    
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),offset_ = 0,limit_ = 1000}, function(arg,del)
for k, v in pairs(del.members_) do
tdcli_function({ID = "GetUser",user_id_ = v.user_id_},function(b,data) 
if data.first_name_ == false then
Group_Kick(msg.chat_id_, data.id_)
end
end,nil)
end
send(msg.chat_id_, msg.id_,'✅| تم طرد المحذوفين')
end,nil)
end
end
if text == 'الصلاحيات' and Mod(msg) then 
local list = database:smembers(bot_id..'Coomds'..msg.chat_id_)
if #list == 0 then
send(msg.chat_id_, msg.id_,'⚠️| لا توجد صلاحيات مضافه')
return false
end
t = "\n📋| قائمة الصلاحيات المضافه \nٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯\n"
for k,v in pairs(list) do
var = database:get(bot_id.."Comd:New:rt:bot:"..v..msg.chat_id_)
if var then
t = t..''..k..'- '..v..' -› ('..var..')\n'
else
t = t..''..k..'- '..v..'\n'
end
end
send(msg.chat_id_, msg.id_,t)
end
if text and text:match("^اضف صلاحيه (.*)$") and Mod(msg) then 
ComdNew = text:match("^اضف صلاحيه (.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا \n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id.."Comd:New:rt"..msg.chat_id_..msg.sender_user_id_,ComdNew)  
database:sadd(bot_id.."Coomds"..msg.chat_id_,ComdNew)  
database:setex(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_,200,true)  
send(msg.chat_id_, msg.id_, "↩️| ارسل الان نوع الرتبـة\n ( *عضـو* / *مميز* / *ادمـن* / *مـدير*}") 
end
if text and text:match("^مسح صلاحيه (.*)$") and Mod(msg) then 
ComdNew = text:match("^مسح صلاحيه (.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا \n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:del(bot_id.."Comd:New:rt:bot:"..ComdNew..msg.chat_id_)
send(msg.chat_id_, msg.id_, "*✅| تم مسح الصلاحيه *\n") 
end
if database:get(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_,"*✅| تم الغاء الامر *\n") 
database:del(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
if text == 'مدير' then
if not Constructor(msg) then
send(msg.chat_id_, msg.id_"*⏬| تستطيع اضافه صلاحيات {ادمن - مميز - عضو} \n↪️| ارسل الصلاحيه مجددا*\n") 
return false
end
end
if text == 'ادمن' then
if not Manager(msg) then 
send(msg.chat_id_, msg.id_,"*⏬| تستطيع اضافه صلاحيات {مميز - عضو} \n↪️| ارسل الصلاحيه مجددا*\n") 
return false
end
end
if text == 'مميز' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,"*⏬| تستطيع اضافه صلاحيات {عضو} \n ↪️| ارسل الصلاحيه مجددا*\n") 
return false
end
end
if text == 'مدير' or text == 'ادمن' or text == 'مميز' or text == 'عضو' then
local textn = database:get(bot_id.."Comd:New:rt"..msg.chat_id_..msg.sender_user_id_)  
database:set(bot_id.."Comd:New:rt:bot:"..textn..msg.chat_id_,text)
send(msg.chat_id_, msg.id_, "✅| تـم اضـافـه الامـر") 
database:del(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
end
if text and text:match('رفع (.*)') and tonumber(msg.reply_to_message_id_) > 0 and Mod(msg) then 
local RTPA = text:match('رفع (.*)')
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا \n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'Coomds'..msg.chat_id_,RTPA) then
function by_reply(extra, result, success)   
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..RTPA..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'..'\n⏫| تم رفعه '..RTPA..'\n')   
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_,RTPA) 
database:sadd(bot_id..'Special:User'..msg.chat_id_,result.sender_user_id_)  
elseif blakrt == 'ادمن' and Manager(msg) then 
send(msg.chat_id_, msg.id_,'\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'..'\n⏫| تم رفعه '..RTPA..'\n')   
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_,RTPA)
database:sadd(bot_id..'Mod:User'..msg.chat_id_,result.sender_user_id_)  
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'..'\n⏫| تم رفعه '..RTPA..'\n')   
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_,RTPA)  
database:sadd(bot_id..'Manager'..msg.chat_id_,result.sender_user_id_)  
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'..'\n⏫| تم رفعه '..RTPA..'\n')   
end
end,nil)   
end   
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text and text:match('تنزيل (.*)') and tonumber(msg.reply_to_message_id_) > 0 and Mod(msg) then 
local RTPA = text:match('تنزيل (.*)')
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا \n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'Coomds'..msg.chat_id_,RTPA) then
function by_reply(extra, result, success)   
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..RTPA..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'..'\n⏬| م تنزيله من '..RTPA..'\n')   
database:srem(bot_id..'Special:User'..msg.chat_id_,result.sender_user_id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_)
elseif blakrt == 'ادمن' and Manager(msg) then 
send(msg.chat_id_, msg.id_,'\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'..'\n⏬| تم تنزيله من '..RTPA..'\n')   
database:srem(bot_id..'Mod:User'..msg.chat_id_,result.sender_user_id_) 
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_)
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'..'\n⏬| تم تنزيله من '..RTPA..'\n')   
database:srem(bot_id..'Manager'..msg.chat_id_,result.sender_user_id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_)
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'..'\n⏬| تم تنزيله من '..RTPA..'\n')   
end
end,nil)   
end   
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text and text:match('^رفع (.*) @(.*)') and Mod(msg) then 
local text1 = {string.match(text, "^(رفع) (.*) @(.*)$")}
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'Coomds'..msg.chat_id_,text1[2]) then
function py_username(extra, result, success)   
if result.id_ then
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..text1[2]..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(text1[3] or 'TuBakx')..')'..'\n⏫| تم رفعه '..text1[2]..'')   
database:sadd(bot_id..'Special:User'..msg.chat_id_,result.id_)  
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_,text1[2])
elseif blakrt == 'ادمن' and Manager(msg) then 
send(msg.chat_id_, msg.id_,'\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(text1[3] or 'TuBakx')..')'..'\n⏫| تم رفعه '..text1[2]..'')   
database:sadd(bot_id..'Mod:User'..msg.chat_id_,result.id_)  
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_,text1[2])
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(text1[3] or 'TuBakx')..')'..'\n⏫| تم رفعه '..text1[2]..'')   
database:sadd(bot_id..'Manager'..msg.chat_id_,result.id_)  
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_,text1[2])
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(text1[3] or 'TuBakx')..')'..'\n⏫| تم رفعه '..text1[2]..'')   
end
else
info = '⚠️| المعرف غلط'
send(msg.chat_id_, msg.id_,info)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text1[3]},py_username,nil) 
end 
end
if text and text:match('^تنزيل (.*) @(.*)') and Mod(msg) then 
local text1 = {string.match(text, "^(تنزيل) (.*) @(.*)$")}
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:sismember(bot_id..'Coomds'..msg.chat_id_,text1[2]) then
function py_username(extra, result, success)   
if result.id_ then
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..text1[2]..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(text1[3] or 'TuBakx')..')'..'\n⏬| تم تنريله من '..text1[2]..'')   
database:srem(bot_id..'Special:User'..msg.chat_id_,result.id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_)
elseif blakrt == 'ادمن' and Manager(msg) then 
send(msg.chat_id_, msg.id_,'\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(text1[3] or 'TuBakx')..')'..'\n⏬| تم تنريله من '..text1[2]..'')   
database:srem(bot_id..'Mod:User'..msg.chat_id_,result.id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_)
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(text1[3] or 'TuBakx')..')'..'\n⏬| تم تنريله من '..text1[2]..'')   
database:srem(bot_id..'Manager'..msg.chat_id_,result.id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_)
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(text1[3] or 'TuBakx')..')'..'\n⏬| تم تنريله من '..text1[2]..'')   
end
else
info = '⚠️| المعرف غلط'
send(msg.chat_id_, msg.id_,info)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text1[3]},py_username,nil) 
end  
end
if text == "مسح رسايلي" or text == "مسح رسائلي" or text == "حذف رسايلي" or text == "حذف رسائلي" then  
send(msg.chat_id_, msg.id_,'🚮| تم مسح رسائلك'  )  
database:del(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) 
end
if text == "رسايلي" or text == "رسائلي" or text == "msg" then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,'📩| عدد رسائلك -› { '..database:get(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_)..'}' ) 
end 
if text == 'تفعيل الاذاعه' and DevTuBacK(msg) then  
if database:get(bot_id..'Bc:Bots') then
database:del(bot_id..'Bc:Bots') 
Text = '\n✅| تم تفعيل الاذاعه' 
else
Text = '\n⏏️| بالتاكيد تم تفعيل الاذاعه'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الاذاعه' and DevTuBacK(msg) then  
if not database:get(bot_id..'Bc:Bots') then
database:set(bot_id..'Bc:Bots',true) 
Text = '\n❎| تم تعطيل الاذاعه' 
else
Text = '\n⏺️| بالتاكيد تم تعطيل الاذاعه'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل التواصل' and DevTuBacK(msg) then  
if database:get(bot_id..'Tuasl:Bots') then
database:del(bot_id..'Tuasl:Bots') 
Text = '\n✅| تم تفعيل التواصل' 
else
Text = '\n🚹| بالتاكيد تم تفعيل التواصل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل التواصل' and DevTuBacK(msg) then  
if not database:get(bot_id..'Tuasl:Bots') then
database:set(bot_id..'Tuasl:Bots',true) 
Text = '\n❎| تم تعطيل التواصل' 
else
Text = '\n⏏️| بالتاكيد تم تعطيل التواصل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل البوت الخدمي' and DevTuBacK(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Free:Bots') then
database:del(bot_id..'Free:Bots') 
Text = '\n✅| تم تفعيل البوت الخدمي' 
else
Text = '\n↩️| بالتاكيد تم تفعيل البوت الخدمي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل البوت الخدمي' and DevTuBacK(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if not database:get(bot_id..'Free:Bots') then
database:set(bot_id..'Free:Bots',true) 
Text = '\n❎| تم تعطيل البوت الخدمي' 
else
Text = '\n↩️| بالتاكيد تم تعطيل البوت الخدمي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text and text:match('^تنظيف (%d+)$') and Manager(msg) then
if not database:get(bot_id..'VlVlVI:Delete:Time'..msg.chat_id_..':'..msg.sender_user_id_) then           
local num = tonumber(text:match('^تنظيف (%d+)$')) 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if num > 1000 then 
send(msg.chat_id_, msg.id_,'⚠️| تستطيع التنظيف 1000 رساله كحد اقصى') 
return false  
end  
local msgm = msg.id_
for i=1,tonumber(num) do
DeleteMessage(msg.chat_id_, {[0] = msgm})
msgm = msgm - 1048576
end
send(msg.chat_id_,msg.id_,'🚮| تم حذف {'..num..'} من الرسائل')  
database:setex(bot_id..'VlVlVI:Delete:Time'..msg.chat_id_..':'..msg.sender_user_id_,300,true)
end
end
if text == "تنظيف الميديا" and Manager(msg) then
msgm = {[0]=msg.id_}
local Message = msg.id_
for i=1,100 do
Message = Message - 1048576
msgm[i] = Message
end
tdcli_function({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = msgm},function(arg,data)
new = 0
msgm2 = {}
for i=0 ,data.total_count_ do
if data.messages_[i] and data.messages_[i].content_ and data.messages_[i].content_.ID ~= "MessageText" then
msgm2[new] = data.messages_[i].id_
new = new + 1
end
end
DeleteMessage(msg.chat_id_,msgm2)
end,nil)  
send(msg.chat_id_, msg.id_,"✅| تم تنظيف جميع الميديا")
end
if (msg.content_.animation_) or (msg.content_.photo_) or (msg.content_.video_) or (msg.content_.document) or (msg.content_.sticker_) and msg.reply_to_message_id_ == 0 then
database:sadd(bot_id.."VlVlVI:allM"..msg.chat_id_, msg.id_)
end
if text == ("امسح") and cleaner(msg) then  
local list = database:smembers(bot_id.."VlVlVI:allM"..msg.chat_id_)
for k,v in pairs(list) do
local Message = v
if Message then
t = "✅| من الميديا "..k.." تم تنظيف"
DeleteMessage(msg.chat_id_,{[0]=Message})
database:del(bot_id.."VlVlVI:allM"..msg.chat_id_)
end
end
if #list == 0 then
t = "⚠️| لا يوجد ميديا في المجموعه"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("عدد الميديا") and cleaner(msg) then  
local num = database:smembers(bot_id.."VlVlVI:allM"..msg.chat_id_)
for k,v in pairs(num) do
local numl = v
if numl then
l = "⏺️| عدد الميديا الموجود هو "..k
end
end
if #num == 0 then
l = "⚠️| لا يوجد ميديا في المجموعه"
end
send(msg.chat_id_, msg.id_, l)
end
if text == "تنظيف التعديل" and Manager(msg) then
Msgs = {[0]=msg.id_}
local Message = msg.id_
for i=1,100 do
Message = Message - 1048576
Msgs[i] = Message
end
tdcli_function({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data)
new = 0
Msgs2 = {}
for i=0 ,data.total_count_ do
if data.messages_[i] and (not data.messages_[i].edit_date_ or data.messages_[i].edit_date_ ~= 0) then
Msgs2[new] = data.messages_[i].id_
new = new + 1
end
end
DeleteMessage(msg.chat_id_,Msgs2)
end,nil)  
send(msg.chat_id_, msg.id_,'🚮| تم تنظيف جميع الرسائل المعدله')
end
if text == "تغير اسم البوت" or text == "تغيير اسم البوت" then 
if DevTuBacK(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id..'Set:Name:Bot'..msg.sender_user_id_,300,true) 
send(msg.chat_id_, msg.id_,"↪️| ارسل لي الاسم الان ")  
end
return false
end

if text == ""..(database:get(bot_id..'Name:Bot') or 'توباك').."" then  
Namebot = (database:get(bot_id..'Name:Bot') or 'توباك')
local TuBacK_Msg = {
'شوكت نخلص منكم الكانسريه بس اصيحوني 🙂؟',
'ياروحي كول اني  '..Namebot..'',
'شتريد من '..Namebot..'',
'دوختو  '..Namebot..'',
'بعد عمري اتفضل 🌝',
'وبعدين وياك ؟ ',
'هلا عمري تفضل؟ ',
'هاا شتريد كافي .',
'خليك ثكيل حبي لضل كل شوي صايحلي ؟',
'كول حبيبي ؟ اني '..Namebot..'',
'عمري فداك '..Namebot..' كول حب'
}
send(msg.chat_id_, msg.id_,'['..TuBacK_Msg[math.random(#TuBacK_Msg)]..']') 
return false
end
if text=="اذاعه خاص" and msg.reply_to_message_id_ == 0 and Sudo(msg) then 
if database:get(bot_id..'Bc:Bots') and not DevTuBacK(msg) then 
send(msg.chat_id_, msg.id_,'⚠️| الاذاعه معطله من قبل المطور الاساسي')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"↪️| ارسل الان اذاعتك \n⏫| للخروج ارسل الغاء") 
return false
end 
if text=="اذاعه" and msg.reply_to_message_id_ == 0 and Sudo(msg) then 
if database:get(bot_id..'Bc:Bots') and not DevTuBacK(msg) then 
send(msg.chat_id_, msg.id_,'⚠️| الاذاعه معطله من قبل المطور الاساسي')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"↪️| ارسل الان اذاعتك \n⏫| للخروج ارسل الغاء ") 
return false
end  
if text=="اذاعه بالتوجيه" and msg.reply_to_message_id_ == 0  and Sudo(msg) then 
if database:get(bot_id..'Bc:Bots') and not DevTuBacK(msg) then 
send(msg.chat_id_, msg.id_,'⚠️| الاذاعه معطله من قبل المطور الاساسي')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"↪️| ارسل لي التوجيه الان") 
return false
end 
if text=="اذاعه بالتوجيه خاص" and msg.reply_to_message_id_ == 0  and Sudo(msg) then 
if database:get(bot_id..'Bc:Bots') and not DevTuBacK(msg) then 
send(msg.chat_id_, msg.id_,'⚠️| الاذاعه معطله من قبل المطور الاساسي')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:setex(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"↪️| ارسل لي التوجيه الان") 
return false
end 
if text and text:match('^ضع اسم (.*)') and Manager(msg) or text and text:match('^وضع اسم (.*)') and Manager(msg) then 
local Name = text:match('^ضع اسم (.*)') or text and text:match('^وضع اسم (.*)') 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
tdcli_function ({ ID = "ChangeChatTitle",chat_id_ = msg.chat_id_,title_ = Name },function(arg,data) 
if data.message_ == "Channel chat title can be changed by administrators only" then
send(msg.chat_id_,msg.id_,"⚠️| البوت ليس ادمن يرجى ترقيتي !")  
return false  
end 
if data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"⚠️| ليست لدي صلاحية تغير اسم الكروب")  
else
sebd(msg.chat_id_,msg.id_,'⏏️| تم تغيير اسم الكروب الى {['..Name..']}')  
end
end,nil) 
end
if text == "تاك للكل" and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100',''), offset_ = 0,limit_ = 200
},function(ta,TuBacK)
local t = "\n📋| قائمة الاعضاء \nٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯\n"
x = 0
local list = TuBacK.members_
for k, v in pairs(list) do
x = x + 1
if database:get(bot_id..'user:Name'..v.user_id_) then
t = t..""..x.." → {[@"..database:get(bot_id..'user:Name'..v.user_id_).."]}\n"
else
t = t..""..x.." → {"..v.user_id_.."}\n"
end
end
send(msg.chat_id_,msg.id_,t)
end,nil)
end
if text and text:match("^تنزيل الكل @(.*)$") and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if (result.id_) then
if tonumber(result.id_) == true then
send(msg.chat_id_, msg.id_,"⚠️| لا تستطيع تنزيل المطور الاساسي")
return false 
end
if database:sismember(bot_id.."Sudo:User",result.id_) then
dev = "المطور ،" else dev = "" end
if database:sismember(bot_id.."CoSu",result.id_) then
cu = "المالك ،" else cu = "" end
if database:sismember(bot_id.."Basic:Constructor"..msg.chat_id_, result.id_) then
crr = "منشئ اساسي ،" else crr = "" end
if database:sismember(bot_id..'Constructor'..msg.chat_id_, result.id_) then
cr = "منشئ ،" else cr = "" end
if database:sismember(bot_id..'Manager'..msg.chat_id_, result.id_) then
own = "مدير ،" else own = "" end
if database:sismember(bot_id..'VlVlVI:MN:TF'..msg.chat_id_, result.id_) then
mn = 'منظف ،' else mn = '' end
if database:sismember(bot_id..'Mod:User'..msg.chat_id_, result.id_) then
mod = "ادمن ،" else mod = "" end
if database:sismember(bot_id..'Special:User'..msg.chat_id_, result.id_) then
vip = "مميز ،" else vip = ""
end
if Can_or_NotCan(result.id_,msg.chat_id_) ~= false then
send(msg.chat_id_, msg.id_,"\n🚹| تم تنزيل الشخص من  ("..dev..""..crr..""..cr..""..own..""..mod..""..mn..""..vip.." ) \n")
else
send(msg.chat_id_, msg.id_,"\n⚠️꒐ ليس لديه رتب \n")
end
if tonumber(msg.sender_user_id_) == true then
database:srem(bot_id.."Sudo:User", result.id_)
database:srem(bot_id.."CoSu", result.id_)
database:srem(bot_id.."Basic:Constructor"..msg.chat_id_,result.id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'VlVlVI:MN:TF'..msg.chat_id_, result.id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
elseif database:sismember(bot_id.."Sudo:User",msg.sender_user_id_) then
database:srem(bot_id..'VlVlVI:MN:TF'..msg.chat_id_, result.id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.id_)
database:srem(bot_id.."Basic:Constructor"..msg.chat_id_,result.id_)
elseif database:sismember(bot_id.."CoSu",msg.sender_user_id_) then
database:srem(bot_id..'VlVlVI:MN:TF'..msg.chat_id_, result.id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.id_)
database:srem(bot_id.."Basic:Constructor"..msg.chat_id_,result.id_)
elseif database:sismember(bot_id.."Basic:Constructor"..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'VlVlVI:MN:TF'..msg.chat_id_, result.id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.id_)
elseif database:sismember(bot_id..'Constructor'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'VlVlVI:MN:TF'..msg.chat_id_, result.id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
elseif database:sismember(bot_id..'Manager'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'VlVlVI:MN:TF'..msg.chat_id_, result.id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
end
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^تنزيل الكل @(.*)$")}, start_function, nil)
end

if text == ("تنزيل الكل") and msg.reply_to_message_id_ ~= 0 and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if tonumber(SUDO) == tonumber(result.sender_user_id_) then
send(msg.chat_id_, msg.id_,"⚠️| لا تستطيع تنزيل المطور الاساسي")
return false 
end
if database:sismember(bot_id..'Sudo:User',result.sender_user_id_) then
dev = 'المطور ،' else dev = '' end
if database:sismember(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_) then
cu = 'المالك ،' else cu = '' end
if database:sismember(bot_id..'Basic:Constructor'..msg.chat_id_, result.sender_user_id_) then
crr = 'منشئ اساسي ،' else crr = '' end
if database:sismember(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_) then
cr = 'منشئ ،' else cr = '' end
if database:sismember(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_) then
own = 'مدير ،' else own = '' end
if database:sismember(bot_id..'VlVlVI:MN:TF'..msg.chat_id_, result.sender_user_id_) then
mn = 'منظف ،' else mn = '' end
if database:sismember(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_) then
mod = 'ادمن ،' else mod = '' end
if database:sismember(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_) then
vip = 'مميز ،' else vip = ''
end
if Can_or_NotCan(result.sender_user_id_,msg.chat_id_) ~= false then
send(msg.chat_id_, msg.id_,"\n 🚹| تم تنزيل الشخص من ( "..dev..''..crr..''..cr..''..own..''..mod..''..mn..''..vip.." ) \n")
else
send(msg.chat_id_, msg.id_,"\n⚠️꒐ ليس لديه رتب\n")
end
if tonumber(SUDO) == tonumber(msg.sender_user_id_) then
database:srem(bot_id..'Sudo:User', result.sender_user_id_)
database:srem(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'VlVlVI:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Dev:AhMd:2',msg.sender_user_id_) then
database:srem(bot_id..'VlVlVI:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Sudo:User',msg.sender_user_id_) then
database:srem(bot_id..'VlVlVI:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'CoSu'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'VlVlVI:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
elseif database:sismember(bot_id..'Basic:Constructor'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'VlVlVI:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Constructor'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'VlVlVI:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Manager'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'VlVlVI:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text == ("مسح ردود المطور") and DevTuBacK(msg) then 
local list = database:smembers(bot_id..'List:Rd:Sudo')
for k,v in pairs(list) do
database:del(bot_id.."Add:Rd:Sudo:Gif"..v)   
database:del(bot_id.."Add:Rd:Sudo:vico"..v)   
database:del(bot_id.."Add:Rd:Sudo:stekr"..v)     
database:del(bot_id.."Add:Rd:Sudo:Text"..v)   
database:del(bot_id.."Add:Rd:Sudo:Photo"..v)
database:del(bot_id.."Add:Rd:Sudo:Video"..v)
database:del(bot_id.."Add:Rd:Sudo:File"..v)
database:del(bot_id.."Add:Rd:Sudo:Audio"..v)
database:del(bot_id..'List:Rd:Sudo')
end
send(msg.chat_id_, msg.id_,"✅| تم مسح ردود المطور")
end

if text == ("ردود المطور") and DevTuBacK(msg) then 
local list = database:smembers(bot_id..'List:Rd:Sudo')
text = "\n📋| قائمة ردود المطور \nٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯\n"
for k,v in pairs(list) do
if database:get(bot_id.."Add:Rd:Sudo:Gif"..v) then
db = 'متحركه'
elseif database:get(bot_id.."Add:Rd:Sudo:vico"..v) then
db = 'بصمه'
elseif database:get(bot_id.."Add:Rd:Sudo:stekr"..v) then
db = 'ملصق'
elseif database:get(bot_id.."Add:Rd:Sudo:Text"..v) then
db = 'رساله'
elseif database:get(bot_id.."Add:Rd:Sudo:Photo"..v) then
db = 'صوره'
elseif database:get(bot_id.."Add:Rd:Sudo:Video"..v) then
db = 'فيديو'
elseif database:get(bot_id.."Add:Rd:Sudo:File"..v) then
db = 'ملف'
elseif database:get(bot_id.."Add:Rd:Sudo:Audio"..v) then
db = 'اغنيه'
end
text = text..""..k.." >> ("..v..") -› {"..db.."}\n"
end
if #list == 0 then
text = "⚠️| لا يوجد ردود للمطور"
end
send(msg.chat_id_, msg.id_,'['..text..']')
end
if text or msg.content_.sticker_ or msg.content_.voice_ or msg.content_.animation_ or msg.content_.audio_ or msg.content_.document_ or msg.content_.photo_ or msg.content_.video_ then  
local test = database:get(bot_id..'Text:Sudo:Bot'..msg.sender_user_id_..':'..msg.chat_id_)
if database:get(bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_) == 'true1' then
database:del(bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_)
if msg.content_.sticker_ then   
database:set(bot_id.."Add:Rd:Sudo:stekr"..test, msg.content_.sticker_.sticker_.persistent_id_)  
end   
if msg.content_.name_ then
database:sadd(bot_id.."Add:Rd:Sudo:name"..msg.sender_user_id_,text) 
end
if msg.content_.voice_ then  
database:set(bot_id.."Add:Rd:Sudo:vico"..test, msg.content_.voice_.voice_.persistent_id_)  
end   
if msg.content_.animation_ then   
database:set(bot_id.."Add:Rd:Sudo:Gif"..test, msg.content_.animation_.animation_.persistent_id_)  
end  
if text then   
text = text:gsub('"','') 
text = text:gsub("'",'') 
text = text:gsub('`','') 
text = text:gsub('*','') 
database:set(bot_id.."Add:Rd:Sudo:Text"..test, text)  
end  
if msg.content_.audio_ then
database:set(bot_id.."Add:Rd:Sudo:Audio"..test, msg.content_.audio_.audio_.persistent_id_)  
end
if msg.content_.name_ then
database:sadd(bot_id.."Add:Rd:Sudo:name"..msg.sender_user_id_,text) 
end
if msg.content_.document_ then
database:set(bot_id.."Add:Rd:Sudo:File"..test, msg.content_.document_.document_.persistent_id_)  
end
if msg.content_.video_ then
database:set(bot_id.."Add:Rd:Sudo:Video"..test, msg.content_.video_.video_.persistent_id_)  
end
if msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo_in_group = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
photo_in_group = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
photo_in_group = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
photo_in_group = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
database:set(bot_id.."Add:Rd:Sudo:Photo"..test, photo_in_group)  
end
send(msg.chat_id_, msg.id_,'✅| تم حفظ الرد')
return false  
end  
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_) == 'true' then
send(msg.chat_id_, msg.id_,'🔖| ارسل الرد الذي تريد اضافته')
database:set(bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_, 'true1')
database:set(bot_id..'Text:Sudo:Bot'..msg.sender_user_id_..':'..msg.chat_id_, text)
database:sadd(bot_id..'List:Rd:Sudo', text)
return false end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'Set:On'..msg.sender_user_id_..':'..msg.chat_id_) == 'true' then
send(msg.chat_id_, msg.id_,'🚮| تم ازالة الرد العام')
list = {"Add:Rd:Sudo:Audio","Add:Rd:Sudo:File","Add:Rd:Sudo:Video","Add:Rd:Sudo:Photo","Add:Rd:Sudo:Text","Add:Rd:Sudo:stekr","Add:Rd:Sudo:vico","Add:Rd:Sudo:Gif"}
for k,v in pairs(list) do
database:del(bot_id..v..text)
end
database:del(bot_id..'Set:On'..msg.sender_user_id_..':'..msg.chat_id_)
database:srem(bot_id..'List:Rd:Sudo', text)
return false
end
end
if text == 'اضف رد للكل' and Sudo(msg) then 
local url,res = https.request('https://anashtick.ml/TuBak.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.TuBak ~= true then
local inline = {{{text="اضغط هنا للشتراك 🚹",url="https://t.me/TuBakx"}}}
SendInline(msg.chat_id_,'عذراً عليك الاشتراك في [. Team TuBak](t.me/TuBaKx) \nليمكنك استخدام البوت بشكل كامل',nil,inline)
return false 
end
send(msg.chat_id_, msg.id_,'📥|  ارسل الكلمه التري تريد اضافتها')
database:set(bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_,true)
return false 
end
if text == 'حذف رد للكل' and Sudo(msg) then 
local url,res = https.request('https://anashtick.ml/TuBak.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.TuBak ~= true then
local inline = {{{text="اضغط هنا للشتراك 🚹",url="https://t.me/TuBakx"}}}
SendInline(msg.chat_id_,'عذراً عليك الاشتراك في [. Team TuBak](t.me/TuBaKx) \nليمكنك استخدام البوت بشكل كامل',nil,inline)
return false 
end
send(msg.chat_id_, msg.id_,'↪️꒐ الان ارسل الرد الذي تريد حذف')
database:set(bot_id..'Set:On'..msg.sender_user_id_..':'..msg.chat_id_,true)
return false 
end
if text and not database:get(bot_id..'Reply:Sudo'..msg.chat_id_) then
if not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
local anemi = database:get(bot_id.."Add:Rd:Sudo:Gif"..text)   
local veico = database:get(bot_id.."Add:Rd:Sudo:vico"..text)   
local stekr = database:get(bot_id.."Add:Rd:Sudo:stekr"..text)     
local text1 = database:get(bot_id.."Add:Rd:Sudo:Text"..text)   
local photo = database:get(bot_id.."Add:Rd:Sudo:Photo"..text)
local video = database:get(bot_id.."Add:Rd:Sudo:Video"..text)
local document = database:get(bot_id.."Add:Rd:Sudo:File"..text)
local audio = database:get(bot_id.."Add:Rd:Sudo:Audio"..text)
if Text then 
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(arg,data)
local NumMsg = database:get(bot_id..'TuBacK:messageUser'..msg.chat_id_..':'..msg.sender_user_id_) or 0
local TotalMsg = Total_message(NumMsg)
local Status_Gps = Get_Rank(msg.sender_user_id_,msg.chat_id_)
local message_edit = database:get(bot_id..'TuBacK:message_edit'..msg.chat_id_..msg.sender_user_id_) or 0
local Text = Text:gsub('#username',(data.username_ or 'لا يوجد')) 
local Text = Text:gsub('#name',data.first_name_)
local Text = Text:gsub('#id',msg.sender_user_id_)
local Text = Text:gsub('#edit',message_edit)
local Text = Text:gsub('#msgs',NumMsg)
local Text = Text:gsub('#stast',Status_Gps)
send(msg.chat_id_, msg.id_,Text)
database:sadd(bot_id.."TuBacK:Spam:Group"..msg.sender_user_id_,text) 
end,nil)
end
if stekr then 
sendSticker(msg.chat_id_,msg.id_,stekr) 
database:sadd(bot_id.."TuBacK:Spam:Group"..msg.sender_user_id_,text) 
end
if veico then 
sendVoice(msg.chat_id_, msg.id_,veico,"")
database:sadd(bot_id.."TuBacK:Spam:Group"..msg.sender_user_id_,text) 
end
if video then 
sendVideo(msg.chat_id_, msg.id_,video,"")
database:sadd(bot_id.."TuBacK:Spam:Group"..msg.sender_user_id_,text) 
end
if anemi then 
sendAnimation(msg.chat_id_, msg.id_,anemi,"")   
database:sadd(bot_id.."TuBacK:Spam:Group"..msg.sender_user_id_,text) 
end
if document then
sendDocument(msg.chat_id_, msg.id_, document)     
database:sadd(bot_id.."TuBacK:Spam:Group"..msg.sender_user_id_,text) 
end  
if audio then
sendAudio(msg.chat_id_,msg.id_,audio)  
database:sadd(bot_id.."TuBacK:Spam:Group"..msg.sender_user_id_,text) 
end
if photo then
sendPhoto(msg.chat_id_,msg.id_,photo,"")
database:sadd(bot_id.."TuBacK:Spam:Group"..msg.sender_user_id_,text) 
return false 
end

------------------------------------------------------------------------
------------------------------------------------------------------------
if text and text:match("^(.*)$") then
if database:get(bot_id.."botss:TuBacK:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_, '\n⏺️| ارسل الكلمه تريد وضعها')
database:set(bot_id.."botss:TuBacK:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_, "true1")
database:set(bot_id.."botss:TuBacK:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_, text)
database:sadd(bot_id.."botss:TuBacK:List:Rd:Sudo", text)
return false end
end
if text and text:match("^(.*)$") then
if database:get(bot_id.."botss:TuBacK:Set:On"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_,"🚮| تم حذف الرد من ردود المتعدده")
database:del(bot_id..'botss:TuBacK:Add:Rd:Sudo:Text'..text)
database:del(bot_id..'botss:TuBacK:Add:Rd:Sudo:Text1'..text)
database:del(bot_id..'botss:TuBacK:Add:Rd:Sudo:Text2'..text)
database:del(bot_id.."botss:TuBacK:Set:On"..msg.sender_user_id_..":"..msg.chat_id_)
database:srem(bot_id.."botss:TuBacK:List:Rd:Sudo", text)
return false
end
end
if text == ("مسح الردود المتعدده") and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local list = database:smembers(bot_id.."botss:TuBacK:List:Rd:Sudo")
for k,v in pairs(list) do  
database:del(bot_id.."botss:TuBacK:Add:Rd:Sudo:Text"..v) 
database:del(bot_id.."botss:TuBacK:Add:Rd:Sudo:Text1"..v) 
database:del(bot_id.."botss:TuBacK:Add:Rd:Sudo:Text2"..v)   
database:del(bot_id.."botss:TuBacK:List:Rd:Sudo")
end
send(msg.chat_id_, msg.id_,"✅| تم حذف ردود المتعدده")
end
------------------------------------------------------------------------
if text1 then 
send(msg.chat_id_, msg.id_,text1)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if stekr then 
sendSticker(msg.chat_id_, msg.id_, 0, 1, nil, stekr)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if veico then 
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil, veico)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if video then 
sendVideo(msg.chat_id_, msg.id_, 0, 1, nil,video)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if anemi then 
sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, anemi, '', nil)  
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if document then
sendDocument(msg.chat_id_, msg.id_, 0, 1,nil, document)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
if audio then
sendAudio(msg.chat_id_,msg.id_,audio)  
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if photo then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil,photo,'')
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
end
end
if text == ("مسح ردود المدير") and Manager(msg) then
local list = database:smembers(bot_id..'List:Manager'..msg.chat_id_..'')
for k,v in pairs(list) do
database:del(bot_id.."Add:Rd:Manager:Gif"..v..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Vico"..v..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Stekrs"..v..msg.chat_id_)     
database:del(bot_id.."Add:Rd:Manager:Text"..v..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Photo"..v..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Video"..v..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:File"..v..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Audio"..v..msg.chat_id_)
database:del(bot_id..'List:Manager'..msg.chat_id_)
end
send(msg.chat_id_, msg.id_,"✅| تم مسح ردود المدير")
end

if text == ("ردود المدير") and Manager(msg) then
local list = database:smembers(bot_id..'List:Manager'..msg.chat_id_..'')
text = "📋| قائمه ردود المدير \nٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯\n"
for k,v in pairs(list) do
if database:get(bot_id.."Add:Rd:Manager:Gif"..v..msg.chat_id_) then
db = 'متحركه'
elseif database:get(bot_id.."Add:Rd:Manager:Vico"..v..msg.chat_id_) then
db = 'بصمه'
elseif database:get(bot_id.."Add:Rd:Manager:Stekrs"..v..msg.chat_id_) then
db = 'ملصق'
elseif database:get(bot_id.."Add:Rd:Manager:Text"..v..msg.chat_id_) then
db = 'رساله'
elseif database:get(bot_id.."Add:Rd:Manager:Photo"..v..msg.chat_id_) then
db = 'صوره'
elseif database:get(bot_id.."Add:Rd:Manager:Video"..v..msg.chat_id_) then
db = 'فيديو'
elseif database:get(bot_id.."Add:Rd:Manager:File"..v..msg.chat_id_) then
db = 'ملف'
elseif database:get(bot_id.."Add:Rd:Manager:Audio"..v..msg.chat_id_) then
db = 'اغنيه'
end
text = text..""..k..">> ("..v..") -› {"..db.."}\n"
end
if #list == 0 then
text = "⚠️| لا يوجد ردود للمدير"
end
send(msg.chat_id_, msg.id_,'['..text..']')
end
if text or msg.content_.sticker_ or msg.content_.voice_ or msg.content_.animation_ or msg.content_.audio_ or msg.content_.document_ or msg.content_.photo_ or msg.content_.video_ then  
local test = database:get(bot_id..'Text:Manager'..msg.sender_user_id_..':'..msg.chat_id_..'')
if database:get(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_) == 'true1' then
database:del(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_)
if msg.content_.sticker_ then   
database:set(bot_id.."Add:Rd:Manager:Stekrs"..test..msg.chat_id_, msg.content_.sticker_.sticker_.persistent_id_)  
end   
if msg.content_.voice_ then  
database:set(bot_id.."Add:Rd:Manager:Vico"..test..msg.chat_id_, msg.content_.voice_.voice_.persistent_id_)  
end   
if msg.content_.animation_ then   
database:set(bot_id.."Add:Rd:Manager:Gif"..test..msg.chat_id_, msg.content_.animation_.animation_.persistent_id_)  
end  
if text then   
text = text:gsub('"','') 
text = text:gsub("'",'') 
text = text:gsub('`','') 
text = text:gsub('*','') 
database:set(bot_id.."Add:Rd:Manager:Text"..test..msg.chat_id_, text)  
end  
if msg.content_.audio_ then
database:set(bot_id.."Add:Rd:Manager:Audio"..test..msg.chat_id_, msg.content_.audio_.audio_.persistent_id_)  
end
if msg.content_.document_ then
database:set(bot_id.."Add:Rd:Manager:File"..test..msg.chat_id_, msg.content_.document_.document_.persistent_id_)  
end
if msg.content_.video_ then
database:set(bot_id.."Add:Rd:Manager:Video"..test..msg.chat_id_, msg.content_.video_.video_.persistent_id_)  
end
if msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo_in_group = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
photo_in_group = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
photo_in_group = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
photo_in_group = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
database:set(bot_id.."Add:Rd:Manager:Photo"..test..msg.chat_id_, photo_in_group)  
end
send(msg.chat_id_, msg.id_,'✅| تم حفظ الرد في المجموعة')
return false  
end  
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_) == 'true' then
send(msg.chat_id_, msg.id_,'↪️| ارسل الرد الذي تريد وضعة')
database:set(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_,'true1')
database:set(bot_id..'Text:Manager'..msg.sender_user_id_..':'..msg.chat_id_, text)
database:del(bot_id.."Add:Rd:Manager:Gif"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Vico"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
database:del(bot_id.."Add:Rd:Manager:Text"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Photo"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Video"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:File"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Audio"..text..msg.chat_id_)
database:sadd(bot_id..'List:Manager'..msg.chat_id_..'', text)
return false end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_..'') == 'true2' then
send(msg.chat_id_, msg.id_,'✅| تم ازالة الرد من المجموعة')
database:del(bot_id.."Add:Rd:Manager:Gif"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Vico"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
database:del(bot_id.."Add:Rd:Manager:Text"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Photo"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Video"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:File"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Audio"..text..msg.chat_id_)
database:del(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_)
database:srem(bot_id..'List:Manager'..msg.chat_id_..'', text)
return false
end
end
if text == 'اضف رد' and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا \n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,'↪️꒐ الان ارسل الرد الذي تريد وضعة')
database:set(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_,true)
return false 
end
if text == 'حذف رد' and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا \n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
send(msg.chat_id_, msg.id_,'↪️꒐ الان ارسل الرد الذي تريد حذفة')
database:set(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_,'true2')
return false 
end
if text and not database:get(bot_id..'Reply:Manager'..msg.chat_id_) then
if not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
local anemi = database:get(bot_id.."Add:Rd:Manager:Gif"..text..msg.chat_id_)   
local veico = database:get(bot_id.."Add:Rd:Manager:Vico"..text..msg.chat_id_)   
local stekr = database:get(bot_id.."Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
local text1 = database:get(bot_id.."Add:Rd:Manager:Text"..text..msg.chat_id_)   
local photo = database:get(bot_id.."Add:Rd:Manager:Photo"..text..msg.chat_id_)
local video = database:get(bot_id.."Add:Rd:Manager:Video"..text..msg.chat_id_)
local document = database:get(bot_id.."Add:Rd:Manager:File"..text..msg.chat_id_)
local audio = database:get(bot_id.."Add:Rd:Manager:Audio"..text..msg.chat_id_)
------------------------------------------------------------------------
------------------------------------------------------------------------
if text and text:match("^وضع لقب (.*)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
local timsh = text:match("^وضع لقب (.*)$")
function start_function(extra, result, success)
local chek = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='..msg.chat_id_..'&user_id='..bot_id)
local getInfo = JSON.decode(chek)
if getInfo.result.can_promote_members == false then
send(msg.chat_id_, msg.id_,'⚠️| لا يمكنني تعديل  او وضع لقب ليس لدي صلاحيه\n⚠️| قم بترقيتي جميع الصلاحيات او صلاحية اضافه مشرف ') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n🚹꒐ العضو :  ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..') '
status  = '\n🏷️| الايدي : '..result.sender_user_id_..'\n✅| تم ضافه {'..timsh..'} كلقب له'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=True&can_restrict_members=false&can_pin_messages=True&can_promote_members=false")
https.request("https://api.telegram.org/bot"..token.."/setChatAdministratorCustomTitle?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&custom_title="..timsh)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if text == ("حذف لقب") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⚠️| البوت ليس مشرف يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n🚹꒐ العضو : ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
status  = '\n🏷️| الايدي : `'..result.sender_user_id_..'`\n✅| تم حذف لقبه من المجموعة'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^حذف لقب @(.*)$") and Constructor(msg) then
local username = text:match("^حذف لقب @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'⚠️| البوت ليس مشرف يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠️| عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
usertext = '\n🚹꒐ العضو :  ['..result.title_..'](t.me/'..(username or 'TuBakx')..')'
status  = '\n✅| تم حذف لقبه من المجموعة'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, 'ℹ️| لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text == 'لقبي' and tonumber(msg.reply_to_message_id_) == 0 then
Ge = https.request("https://api.telegram.org/bot"..token.."/getChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..msg.sender_user_id_)
GeId = JSON.decode(Ge)
if not GeId.result.custom_title then
send(msg.chat_id_, msg.id_,'🚹| وينك وين القب ') 
else
send(msg.chat_id_, msg.id_,'⏏️| لقبك هو : '..GeId.result.custom_title) 
end
end
if text == "فحص البوت" and Manager(msg) then
local chek = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='..msg.chat_id_..'&user_id='..bot_id)
local getInfo = JSON.decode(chek)
if getInfo.ok == true then
if getInfo.result.can_change_info == true then
INf = '❴ ✔️ ❵' 
else 
INf = '❴ ✖ ❵' 
end
if getInfo.result.can_delete_messages == true then
DEL = '❴ ✔️ ❵' 
else 
DEL = '❴ ✖ ❵' 
end
if getInfo.result.can_invite_users == true then
INv = '❴ ✔️ ❵' 
else
INv = '❴ ✖ ❵' 
end
if getInfo.result.can_pin_messages == true then
Pin = '❴ ✔️ ❵' 
else
Pin = '❴ ✖ ❵' 
end
if getInfo.result.can_restrict_members == true then
REs = '❴ ✔️ ❵' 
else 
REs = '❴ ✖ ❵' 
end
if getInfo.result.can_promote_members == true then
PRo = '❴ ✔️ ❵'
else
PRo = '❴ ✖ ❵'
end 
send(msg.chat_id_, msg.id_,'\n↪️| صلاحيات البوت هي\nٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯\n◀️علامة ال {✔️} تعني مفعل\n◀️| علامة ال {✖} تعني غير مفعل\nٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯\n🚸| تغير معلومات المجموعة ‹- '..INf..'\n📩| حذف الرسائل ‹- '..DEL..'\n🚯| حظر المستخدمين ‹- '..REs..'\n👥| دعوة المستخدمين ‹- '..INv..'\n💭| ثتبيت الرسالة ‹- '..Pin..'\n🛡️| اضافة مشرفين ‹- '..PRo)   
end
end

if text == 'صيح المشرفين' or text == "تاك للمشرفين" or text == "وين المشرفين" or text == "المشرفين" then
if not database:get(bot_id..'TuBakx:Tag:Admins'..msg.chat_id_)  then 
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,b)  
if b.username_ then 
User_id = "@"..b.username_
else
User_id = msg.sender_user_id_
end 
local t = "\n🚹| المستخدم ~ ["..User_id .."] يصيح يصيحكم \nٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯\n"
k = 0
for i,v in pairs(data.members_) do
if bot_id ~= v.user_id_ then 
k = k + 1
local username = database:get(bot_id.."user:Name"..v.user_id_)
if database:get(bot_id..'user:Name'..v.user_id_) then
t = t..""..k.." → {[@"..database:get(bot_id..'user:Name'..v.user_id_).."]}\n"
else
t = t..""..k.." → {`"..v.user_id_.."`}\n"
end
end
end
send(msg.chat_id_, msg.id_,t)
end,nil)
end,nil)
end
end
if text == "الساعه" then
local ramsesj20 = "\n⏰| الساعه الان : "..os.date("%I:%M%p")
send(msg.chat_id_, msg.id_,ramsesj20)
end

if text == "التاريخ" then
local ramsesj20 =  "\n📆| التاريخ : "..os.date("%Y/%m/%d")
send(msg.chat_id_, msg.id_,ramsesj20)
end

if text == ("الردود المتعدده") and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local list = database:smembers(bot_id.."botss:TuBacK:List:Rd:Sudo")
text = "\n📋| قائمة الردود المتعدده \nٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯\n"
for k,v in pairs(list) do
db = "رساله "
text = text..""..k.." => {"..v.."} => {"..db.."}\n"
end
if #list == 0 then
text = "ℹ️| لا توجد ردود متعدده"
end
send(msg.chat_id_, msg.id_,"["..text.."]")
end
if text == "اضف رد متعدد" and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id.."botss:TuBacK:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,true)
return send(msg.chat_id_, msg.id_,"↪️| ارسل الرد الذي اريد اضافته")
end
if text == "حذف رد متعدد" and CoSu(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:set(bot_id.."botss:TuBacK:Set:On"..msg.sender_user_id_..":"..msg.chat_id_,true)
return send(msg.chat_id_, msg.id_,"↪️| ارسل الان الكلمه لحذفها ")
end
if text then  
local test = database:get(bot_id.."botss:TuBacK:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_)
if database:get(bot_id.."botss:TuBacK:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true1" then
database:set(bot_id.."botss:TuBacK:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,'rd1')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
database:set(bot_id.."botss:TuBacK:Add:Rd:Sudo:Text"..test, text)  
end  
send(msg.chat_id_, msg.id_,"↪️| تم حفظ الرد الاول ارسل الرد الثاني")
return false  
end  
end
if text then  
local test = database:get(bot_id.."botss:TuBacK:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_)
if database:get(bot_id.."botss:TuBacK:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "rd1" then
database:set(bot_id.."botss:TuBacK:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,'rd2')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
database:set(bot_id.."botss:TuBacK:Add:Rd:Sudo:Text1"..test, text)  
end  
send(msg.chat_id_, msg.id_,"↪️| تم حفظ الرد الثاني ارسل الرد الثالث")
return false  
end  
end
if text then  
local test = database:get(bot_id.."botss:TuBacK:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_)
if database:get(bot_id.."botss:TuBacK:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "rd2" then
database:set(bot_id.."botss:TuBacK:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,'rd3')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
database:set(bot_id.."botss:TuBacK:Add:Rd:Sudo:Text2"..test, text)  
end  
send(msg.chat_id_, msg.id_,"✅| تم حفظ جميع الردود")
return false  
end  
end
if text then
local Text = database:get(bot_id.."botss:TuBacK:Add:Rd:Sudo:Text"..text)   
local Text1 = database:get(bot_id.."botss:TuBacK:Add:Rd:Sudo:Text1"..text)   
local Text2 = database:get(bot_id.."botss:TuBacK:Add:Rd:Sudo:Text2"..text)   
if Text or Text1 or Text2 then 
local texting = {
Text,
Text1,
Text2
}
Textes = math.random(#texting)
send(msg.chat_id_, msg.id_,texting[Textes])
end
end
------------------------------------------------------------------------
if text1 then 
send(msg.chat_id_, msg.id_, text1)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if stekr then 
sendSticker(msg.chat_id_, msg.id_, 0, 1, nil, stekr)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if veico then 
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil, veico)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if video then 
sendVideo(msg.chat_id_, msg.id_, 0, 1, nil,video)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if anemi then 
sendDocument(msg.chat_id_, msg.id_, 0, 1,nil, anemi)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if document then
sendDocument(msg.chat_id_, msg.id_, 0, 1,nil, document)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
if audio then
sendAudio(msg.chat_id_,msg.id_,audio)  
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if photo then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil,photo,photo_caption)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
end
end

if text == ""..(database:get(bot_id..'Name:Bot') or 'توباك').." غادر" or text == 'بوت غادر' then  
if Sudo(msg) and not database:get(bot_id..'Left:Bot'..msg.chat_id_)  then 
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
send(msg.chat_id_, msg.id_,'✅| تم مغادرة المجموعة') 
database:srem(bot_id..'Chek:Groups',msg.chat_id_)  
end
return false  
end

if text == 'بوت' then
Namebot = (database:get(bot_id..'Name:Bot') or 'توباك')
local texting = {"لتكول بوت اسمي "..Namebot.." ؟ 🌚","اسمي "..Namebot.." حب","عندي اسم لتلح 🙂 ؟","صيحولي "..Namebot.." شوكت نخلص منكم كانسرية صيحلي باسمي 🌚😹","لتكول بوت لاتنطرد عندي اسم 🌝😹"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end

if text == 'الاحصائيات' then
if Sudo(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = '*📊꒐ احصائيات البوت : * \n\n'..' 🚻꒐ عدد المجموعات : {'..Groups..'}'..'\n 🚹꒐ عدد المحادثات : {'..Users..'}'
send(msg.chat_id_, msg.id_,Text) 
end
return false
end
if text == 'المجموعات' then
if Sudo(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = ' *🚻꒐ عدد المجموعات :* {`'..Groups..'`}'
send(msg.chat_id_, msg.id_,Text) 
end
return false
end
if text == 'المشتركين' then
if Sudo(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = ' *🚹꒐ عدد المستخدمين : *{`'..Users..'|}'
send(msg.chat_id_, msg.id_,Text) 
end
return false
end
---------------------------------------------------------------------------------------------
if text == 'تفعيل تاك المشرفين' and Manager(msg) then   
if database:get(bot_id..'TuBakx:Tag:Admins'..msg.chat_id_)  then
database:del(bot_id..'TuBakx:Tag:Admins'..msg.chat_id_) 
local Text = '✅| تم تفعيل تاك المشرفين'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'✅| بالتأكيد تم تفعيل تاك المشرفين')  
end
end
if text == 'تعطيل تاك المشرفين' and Manager(msg) then  
if not database:get(bot_id..'TuBakx:Tag:Admins'..msg.chat_id_)  then
database:set(bot_id..'TuBakx:Tag:Admins'..msg.chat_id_,true) 
local Text = '❎| تم تعطيل تاك المشرفين'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'❎| بالتأكيد تم تعطيل تاك المشرفين')  
end
end
if text == 'تفعيل المغادره' and DevTuBacK(msg) then   
if database:get(bot_id..'Left:Bot'..msg.chat_id_) then
database:del(bot_id..'Left:Bot'..msg.chat_id_)  
local Text = '✅| تم تفعيل المغادرة'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'✅| بالتأكيد تم تفعيل المغادرة')  
end
end
if text == 'تعطيل المغادره' and DevTuBacK(msg) then  
if not database:get(bot_id..'Left:Bot'..msg.chat_id_) then
database:del(bot_id..'Left:Bot'..msg.chat_id_)  
local Text = '❎| تم تعطيل المغادرة'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'❎| بالتأكيد تم تعطيل المغادرة')  
end
end
if text == 'تفعيل ردود المدير' and Manager(msg) then   
if database:get(bot_id..'Reply:Manager'..msg.chat_id_) then
database:del(bot_id..'Reply:Manager'..msg.chat_id_)  
local Text = '✅| تم تفعيل ردود المدير'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'✅| بالتأكيد تم تفعيل ردود المدير')  
end
end
if text == 'تعطيل ردود المدير' and Manager(msg) then  
if not database:get(bot_id..'Reply:Manager'..msg.chat_id_) then
database:set(bot_id..'Reply:Manager'..msg.chat_id_,true)  
local Text = '❎| تم تعطيل ردود المدير'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'❎| بالتأكيد تم تعطيل ردود المدير')  
end
end
if text == 'تفعيل ردود المطور' and Manager(msg) then   
if database:get(bot_id..'Reply:Sudo'..msg.chat_id_) then
database:del(bot_id..'Reply:Sudo'..msg.chat_id_)  
local Text = '✅| تم تفعيل ردود المطور'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'✅| بالتأكيد تم تفعيل ردود المطور')  
end
end
if text == 'تعطيل ردود المطور' and Manager(msg) then  
if not database:get(bot_id..'Reply:Sudo'..msg.chat_id_) then
database:set(bot_id..'Reply:Sudo'..msg.chat_id_,true)   
local Text = '❎| تم تعطيل ردود المطور'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'❎| بالتأكيد تم تعطيل ردود المدير')  
end
end
if text == 'تفعيل الايدي' and Manager(msg) then   
if database:get(bot_id..'Bot:Id'..msg.chat_id_)  then
database:del(bot_id..'Bot:Id'..msg.chat_id_) 
local Text = '✅| تم تفعيل الايدي'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'✅| بالتأكيد تم تفعيل الايدي')  
end
end
if text == 'تعطيل الايدي' and Manager(msg) then  
if not database:get(bot_id..'Bot:Id'..msg.chat_id_)  then
database:set(bot_id..'Bot:Id'..msg.chat_id_,true) 
local Text = '❎| تم تعطيل الايدي'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'❎| بالتأكيد تم تعطيل الايدي')  
end
end
if text == 'تفعيل الايدي بالصوره' and Manager(msg) then   
if database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_)  then
database:del(bot_id..'Bot:Id:Photo'..msg.chat_id_) 
local Text = '✅| تم تفعيل الايدي بالصورة'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'✅| بالتأكيد تم تفعيل الايدي بالصورة')  
end
end
if text == 'تعطيل الايدي بالصوره' and Manager(msg) then  
if not database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_)  then
database:set(bot_id..'Bot:Id:Photo'..msg.chat_id_,true) 
local Text = '❎| تم تعطيل الايدي بالصورة'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'❎| بالتأكيد تم تعطيل الايدي بالصورة')  
end
end
if text == 'تفعيل الحظر' and Constructor(msg) then   
if database:get(bot_id..'Lock:kick'..msg.chat_id_)  then
database:del(bot_id..'Lock:kick'..msg.chat_id_) 
local Text = '✅| تم تفعيل الحظر'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'✅| بالتأكيد تم تفعيل الحظر')  
end
end
if text == 'تعطيل الحظر' and Constructor(msg) then  
if not database:get(bot_id..'Lock:kick'..msg.chat_id_)  then
database:set(bot_id..'Lock:kick'..msg.chat_id_,true) 
local Text = '❎| تم تعطيل الحظر'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'❎| بالتأكيد تم تعطيل الحظر')  
end
end
if text == 'تفعيل الرفع' and Constructor(msg) then   
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_)  then
database:del(bot_id..'Lock:Add:Bot'..msg.chat_id_) 
local Text = '✅| تم تفعيل الرفع في البوت'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'✅| بالتأكيد تم تفعيل الرفع')  
end
end
if text == 'تعطيل الرفع' and Constructor(msg) then  
if not database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_)  then
database:set(bot_id..'Lock:Add:Bot'..msg.chat_id_,true) 
local Text = '❎| تم تعطيل الرفع في البوت'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'❎| بالتأكيد تم تعطيل الرفع')  
end
end
--------------------------------------------------------------
---------------------------------------------------------------------------------------------
if text == 'ايدي' and tonumber(msg.reply_to_message_id_) > 0 then
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(extra,data) 
local Msguser = tonumber(database:get(bot_id..'Msg_User'..msg.chat_id_..':'..result.sender_user_id_) or 1) 
local Contact = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..result.sender_user_id_) or 0) 
local NUMPGAME = tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..result.sender_user_id_) or 0)
local edit = tonumber(database:get(bot_id..'edits'..msg.chat_id_..result.sender_user_id_) or 0)
local rtp = Rutba(result.sender_user_id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.sender_user_id_
send(msg.chat_id_, msg.id_,'*🚹| ايديه || '..iduser..'\n🏷️| معرفه ||* '..username..'\n*📌| رتبته || '..rtp..'\n🚮| التعديل || '..edit..'\n💰| نقاطه || '..NUMPGAME..'\n👥| جهاته || '..Contact..'\n💭| رسائله || '..Msguser..'*')
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text and text:match("^ايدي @(.*)$") then
local username = text:match("^ايدي @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(extra,data) 
local Msguser = tonumber(database:get(bot_id..'Msg_User'..msg.chat_id_..':'..result.id_) or 1) 
local Contact = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..result.id_) or 0) 
local NUMPGAME = tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..result.id_) or 0)
local edit = tonumber(database:get(bot_id..'edits'..msg.chat_id_..result.id_) or 0)
local rtp = Rutba(result.id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.id_
send(msg.chat_id_, msg.id_,'*🚹| ايديه || '..iduser..'\n🏷️| معرفه ||* '..username..'\n*📌| رتبته || '..rtp..'\n🚮| التعديل || '..edit..'\n💰| نقاطه || '..NUMPGAME..'\n👥| جهاته || '..Contact..'\n💭| رسائله || '..Msguser..'*')
end,nil)
else
send(msg.chat_id_, msg.id_,' ⚠️| المعرف غير صحيح ')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text == 'رتبتي' then
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
send(msg.chat_id_, msg.id_,'↩️| رتبتك في البوت : '..rtp)
end
if text == "اسمي"  then 
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(extra,result,success)
if result.first_name_  then
first_name = '🚹| اسمك الاول -› {`'..(result.first_name_)..'`}'
else
first_name = ''
end   
if result.last_name_ then 
last_name = '↩️| اسمك الثاني -› {`'..result.last_name_..'`}' 
else
last_name = ''
end      
send(msg.chat_id_, msg.id_,first_name..'\n'..last_name) 
end,nil)
end 
if text == 'ايديي' then
send(msg.chat_id_, msg.id_,'🚹| ايديك -› '..msg.sender_user_id_)
end
if text == 'الرتبه' and tonumber(msg.reply_to_message_id_) > 0 then
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(extra,data) 
local rtp = Rutba(result.sender_user_id_,msg.chat_id_)
local username = ' ['..data.first_name_..'](t.me/'..(data.username_ or 'TuBakx')..')'
local iduser = result.sender_user_id_
send(msg.chat_id_, msg.id_,'*🚹| العضو -› (*'..username..'*)\n↩️| الرتبه -› ('..rtp..')*\n')
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
---------
if text and text:match("^الرتبه @(.*)$") then
local username = text:match("^الرتبه @(.*)$")
function start_function(extra, result, success)
if result.id_ then
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(extra,data) 
local rtp = Rutba(result.id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.id_
send(msg.chat_id_, msg.id_,'*🚹| العضو -› (*'..username..'*)\n↩️| الرتبه -› ('..rtp..')*\n')
end,nil)
else
send(msg.chat_id_, msg.id_,'ℹ️| المعرف غير صحيح ')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text == 'كشف' and tonumber(msg.reply_to_message_id_) > 0 then
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(extra,data) 
local rtp = Rutba(result.sender_user_id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.sender_user_id_
send(msg.chat_id_, msg.id_,'🚹| الايدي -› ('..iduser..')\n🏷️| المعرف -› ('..username..')\n⏏️| الرتبه -› ('..rtp..')\n🎭| نوع الكشف -› بالرد')
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
---------
if text and text:match("^كشف @(.*)$") then
local username = text:match("^كشف @(.*)$")
function start_function(extra, result, success)
if result.id_ then
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(extra,data) 
local rtp = Rutba(result.id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.id_
send(msg.chat_id_, msg.id_,'🚹| الايدي -› ('..iduser..')\n🏷️| المعرف -› ('..username..')\n⏏️| الرتبه -› ('..rtp..')\n🎭| نوع الكشف -› بالمعرف')
end,nil)
else
send(msg.chat_id_, msg.id_,'⚠️| المعرف غير صحيح')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text==('عدد المجموعه') and Mod(msg) then  
if msg.can_be_deleted_ == false then 
send(msg.chat_id_,msg.id_,"ℹ️| البوت ليس ادمن \n") 
return false  
end 
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,ta) 
tdcli_function({ID="GetChannelFull",channel_id_ = msg.chat_id_:gsub('-100','')},function(arg,data) 
local ahmd = '🚻| عدد الادمنيه : '..data.administrator_count_..
'\n\n🚯| عدد المطرودين : '..data.kicked_count_..
'\n\n👥| عدد الاعضاء : '..data.member_count_..
'\n\n📩| عدد رسائل الكروب : '..(msg.id_/2097152/0.5)..
'\n\n◀️| اسم المجموعة : ['..ta.title_..']'
send(msg.chat_id_, msg.id_, ahmd) 
end,nil)
end,nil)
end 
if text == 'اطردني' or text == 'طردني' then
if not database:get(bot_id..'Cick:Me'..msg.chat_id_) then
if Can_or_NotCan(msg.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\nℹ️| عذرا لا استطيع طرد ( '..Rutba(msg.sender_user_id_,msg.chat_id_)..' )')
return false
end
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=msg.sender_user_id_,status_={ID="ChatMemberStatusKicked"},},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,' ⚠️| ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if (data and data.code_ and data.code_ == 3) then 
send(msg.chat_id_, msg.id_,'⚠️| البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
if data and data.code_ and data.code_ == 400 and data.message_ == "USER_ADMIN_INVALID" then 
send(msg.chat_id_, msg.id_,'⚠️| عذرا لا استطيع طرد ادمنية المجموعة') 
return false  
end
if data and data.ID and data.ID == 'Ok' then
send(msg.chat_id_, msg.id_,'🚮| تم طردك من المجموعة') 
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = msg.sender_user_id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
return false
end
end,nil)   
else
send(msg.chat_id_, msg.id_,'ℹ️| امر اطردني معطل') 
end
end
if text and text:match("^صيح (.*)$") and not database:get(bot_id..'Seh:User'..msg.chat_id_)  then 
local username = text:match("^صيح (.*)$") 
if not database:get(bot_id..'Seh:User'..msg.chat_id_) then
function start_function(extra, result, success)
if result and result.message_ and result.message_ == "USERNAME_NOT_OCCUPIED" then 
send(msg.chat_id_, msg.id_,'⚠️| المعرف غلط ') 
return false  
end
if result and result.type_ and result.type_.channel_ and result.type_.channel_.ID == "Channel" then
send(msg.chat_id_, msg.id_,'ℹ️| لا استطيع اصيح معرف قنوات') 
return false  
end
if result.type_.user_.type_.ID == "UserTypeBot" then
send(msg.chat_id_, msg.id_,'⚠️| لا استطيع اصيح معرف بوتات') 
return false  
end
if result and result.type_ and result.type_.channel_ and result.type_.channel_.is_supergroup_ == true then
send(msg.chat_id_, msg.id_,'ℹ️| لا اسطيع صيح معرفات الكروبات') 
return false  
end
if result.id_ then
send(msg.chat_id_, msg.id_,'🚺| تعال حبي يصيحونك بل كروب [@'..username..']') 
return false
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
else
send(msg.chat_id_, msg.id_,'ℹ️| امر صيح معطل') 
end
return false
end

if text == 'منو ضافني' then
if not database:get(bot_id..'Added:Me'..msg.chat_id_) then
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da and da.status_.ID == "ChatMemberStatusCreator" then
send(msg.chat_id_, msg.id_,'🚹| انت منشئ الكروب') 
return false
end
local Added_Me = database:get(bot_id.."Who:Added:Me"..msg.chat_id_..':'..msg.sender_user_id_)
if Added_Me then 
tdcli_function ({ID = "GetUser",user_id_ = Added_Me},function(extra,result,success)
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
Text = '🚺| الشخص الذي قام باضافتك -› '..Name
sendText(msg.chat_id_,Text,msg.id_/2097152/0.5,'md')
end,nil)
else
send(msg.chat_id_, msg.id_,'ℹ️| انت دخلت عبر الرابط') 
end
end,nil)
else
send(msg.chat_id_, msg.id_,'ℹ️| امر منو ضافني معطل') 
end
end
-----------------------------------------------------------------------

if text == 'تفعيل صيح' and Manager(msg) then   
if database:get(bot_id..'Seh:User'..msg.chat_id_)  then
database:del(bot_id..'Seh:User'..msg.chat_id_) 
local Text = '✅| تم تفعيل صيح'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'✅| بالتأكيد تم تفعيل صيح')  
end
end
if text == 'تعطيل صيح' and Manager(msg) then  
if not database:get(bot_id..'Seh:User'..msg.chat_id_)  then
database:set(bot_id..'Seh:User'..msg.chat_id_,true) 
local Text = '❎| تم تعطيل صيح'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'❎| بالتأكيد تم تعطيل صيح')  
end
end
if text == 'تفعيل الردود' and Manager(msg) then   
if database:get(bot_id..'lock:add'..msg.chat_id_)  then
database:del(bot_id..'lock:add'..msg.chat_id_) 
local Text = '✅| تم تفعيل الردود'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'✅| بالتأكيد تم تفعيل الردود')  
end
end
if text == 'تعطيل الردود' and Manager(msg) then  
if not database:get(bot_id..'lock:add'..msg.chat_id_)  then
database:set(bot_id..'lock:add'..msg.chat_id_,true) 
local Text = '❎| تم تعطيل الردود'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'❎| بالتأكيد تم تعطيل الردود')  
end
end
if text == 'تفعيل اطردني' and Manager(msg) then   
if database:get(bot_id..'Cick:Me'..msg.chat_id_)  then
database:del(bot_id..'Cick:Me'..msg.chat_id_) 
local Text = '✅| تم تفعيل اطردني'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'✅| بالتأكيد تم تفعيل اطردني')  
end
end
if text == 'تعطيل اطردني' and Manager(msg) then  
if not database:get(bot_id..'Cick:Me'..msg.chat_id_)  then
database:set(bot_id..'Cick:Me'..msg.chat_id_,true) 
local Text = '❎| تم تعطيل اطردني'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'❎| بالتأكيد تم تعطيل اطردني')  
end
end

if text == 'تفعيل ضافني' and Manager(msg) then   
if database:get(bot_id..'Added:Me'..msg.chat_id_)  then
database:del(bot_id..'Added:Me'..msg.chat_id_) 
local Text = '✅| تم تفعيل ضافني'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'✅| بالتأكيد تم تفعيل ضافني')  
end
end
if text == 'تعطيل ضافني' and Manager(msg) then  
if not database:get(bot_id..'Added:Me'..msg.chat_id_)  then
database:set(bot_id..'Added:Me'..msg.chat_id_,true) 
local Text = '❎| تم تعطيل ضافني'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'❎| بالتأكيد تم تعطيل ضافني')  
end
end
------------------------------------------------------------------------
if text == 'تفعيل الانستا' and Manager(msg) then   
if database:get(bot_id..'TuBakx:insta_bot'..msg.chat_id_)  then
database:del(bot_id..'TuBakx:insta_bot'..msg.chat_id_) 
local Text = '✅| تم تفعيل الانستا'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'✅| بالتأكيد تم تفعيل الانستا')  
end
end
if text == 'تعطيل الانستا' and Manager(msg) then  
if not database:get(bot_id..'TuBakx:insta_bot'..msg.chat_id_)  then
database:set(bot_id..'TuBakx:insta_bot'..msg.chat_id_,true) 
local Text = '❎| تم تعطيل الانستا'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'❎| بالتأكيد تم تعطيل الانستا')  
end
end
if text and text:match("^معلومات (.*)$") and not database:get(bot_id..'TuBakx:insta_bot'..msg.chat_id_)  then 
local Textni = text:match("^معلومات (.*)$") 
data,res = https.request('https://forhassan.ml/Black/insta.php?username='..URL.escape(Textni)..'')
if res == 200 then
muaed = json:decode(data)
if muaed.Info == true then
local filee = download_to_file(muaed.ph,msg.sender_user_id_..'.jpg')
sendPhoto(msg.chat_id_, msg.id_,'./'..msg.sender_user_id_..'.jpg',muaed.info)     
os.execute('rm -rf ./'..msg.sender_user_id_..'.jpg') 
end
end
end
-------------------------------
if text == 'تفعيل الزخرفه' and Manager(msg) then   
if database:get(bot_id..'ahmd:zhrf_Bots'..msg.chat_id_)  then
database:del(bot_id..'ahmd:zhrf_Bots'..msg.chat_id_) 
local Text = '✅| تم تفعيل الزخرفه'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'✅| بالتأكيد تم تفعيل الزخرفه')  
end
end
if text == 'تعطيل الزخرفه' and Manager(msg) then  
if not database:get(bot_id..'ahmd:zhrf_Bots'..msg.chat_id_)  then
database:set(bot_id..'ahmd:zhrf_Bots'..msg.chat_id_,true) 
local Text = '❎| تم تعطيل الزخرفه'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'❎| بالتأكيد تم تعطيل الزخرفه')  
end
end
if text and text:match("^زخرفه (.*)$") and not database:get(bot_id..'ahmd:zhrf_Bots'..msg.chat_id_)  then 
local TextZhrfa = text:match("^زخرفه (.*)$")
zh = https.request('https://anashtick.ml/TuBakTeAM/zhrf.php?post='..URL.escape(TextZhrfa)..'')
zx = JSON.decode(zh)
t = "\n📋| قائمه الزغرفه \nٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯\n"
i = 0
for k,v in pairs(zx.ok) do
i = i + 1
t = t..i.."-  "..v.." \n"
end
send(msg.chat_id_, msg.id_, t..'ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ٴ\n🚹| [Source TuBaK TeAM . ](t.me/Tubakx) ')
end
-------------------------------
if text == 'تفعيل الابراج' and Manager(msg) then   
if database:get(bot_id..'ahmd:brj_Bots'..msg.chat_id_)  then
database:del(bot_id..'ahmd:brj_Bots'..msg.chat_id_) 
local Text = '✅| تم تفعيل الابراج'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'✅| بالتأكيد تم تفعيل الابراج')  
end
end
if text == 'تعطيل الابراج' and Manager(msg) then  
if not database:get(bot_id..'ahmd:brj_Bots'..msg.chat_id_)  then
database:set(bot_id..'ahmd:brj_Bots'..msg.chat_id_,true) 
local Text = '❎| تم تعطيل الابراج'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'❎| بالتأكيد تم تعطيل الابراج')  
end
end
if text and text:match("^برج (.*)$") and not database:get(bot_id..'ahmd:brj_Bots'..msg.chat_id_)  then 
local Textbrj = text:match("^برج (.*)$")
gk = https.request('https://rudi-dev.tk/Amir2/Boyka.php?br='..URL.escape(Textbrj)..'')
br = JSON.decode(gk)
i = 0
for k,v in pairs(br.ok) do
i = i + 1
t = v.."\n"
end
send(msg.chat_id_, msg.id_, t)
end
-------------------------------
if text == 'تفعيل حساب العمر' and Manager(msg) then   
if database:get(bot_id..'ahmd:age_Bots'..msg.chat_id_)  then
database:del(bot_id..'ahmd:age_Bots'..msg.chat_id_) 
local Text = '✅| تم تفعيل حساب العمر'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'✅| بالتأكيد تم تفعيل حساب العمر')  
end
end
if text == 'تعطيل حساب العمر' and Manager(msg) then  
if not database:get(bot_id..'ahmd:age_Bots'..msg.chat_id_)  then
database:set(bot_id..'ahmd:age_Bots'..msg.chat_id_,true) 
local Text = '❎| تم تعطيل حساب العمر'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'❎| بالتأكيد تم تعطيل حساب العمر')  
end
end
if text and text:match("^احسب (.*)$") and not database:get(bot_id..'ahmd:age_Bots'..msg.chat_id_)  then 
local Textage = text:match("^احسب (.*)$")
ge = https.request('https://rudi-dev.tk/Amir3/Boyka.php?age='..URL.escape(Textage)..'')
ag = JSON.decode(ge)
i = 0
for k,v in pairs(ag.ok) do
i = i + 1
t = v.."\n"
end
send(msg.chat_id_, msg.id_, t)
end
-------------------------------
if text == 'تفعيل الافلام' and Manager(msg) then   
if database:get(bot_id..'AhMd:movie_bot'..msg.chat_id_)  then
database:del(bot_id..'AhMd:movie_bot'..msg.chat_id_) 
local Text = '✅| تم تفعيل الافلام'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'✅| بالتأكيد تم تفعيل الافلام')  
end
end
if text == 'تعطيل الافلام' and Manager(msg) then  
if not database:get(bot_id..'AhMd:movie_bot'..msg.chat_id_)  then
database:set(bot_id..'AhMd:movie_bot'..msg.chat_id_,true) 
local Text = '❎| تم تعطيل الافلام'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'❎| بالتأكيد تم تعطيل الافلام')  
end
end
if text and text:match("^فلم (.*)$") and not database:get(bot_id..'AhMd:movie_bot'..msg.chat_id_)  then 
local Textm = text:match("^فلم (.*)$")
data,res = https.request('https://forhassan.ml/Black/movie.php?serch='..URL.escape(Textm)..'')
if res == 200 then
getmo = json:decode(data)
if getmo.Info == true then
local Text ='قصه الفلم'..getmo.info
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'مشاهده الفلم بجوده 240',url=getmo.sd}},
{{text = 'مشاهده الفلم بجوده 480', url=getmo.Web},{text = 'مشاهده الفلم بجوده 1080', url=getmo.hd}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
end
--------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
if text == 'تفعيل نسبه الحب' and Manager(msg) then   
if database:get(bot_id..'Cick:lov'..msg.chat_id_)  then
database:del(bot_id..'Cick:lov'..msg.chat_id_) 
local Text = '✅| تم تفعيل نسبه الحب \n\n◀️| ارسل كلمه : نسبه الحب'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'✅| بالتأكيد تم تفعيل نسبة الحب')  
end
end
if text == 'تعطيل نسبه الحب' and Manager(msg) then  
if not database:get(bot_id..'Cick:lov'..msg.chat_id_)  then
database:set(bot_id..'Cick:lov'..msg.chat_id_,true) 
local Text = '❎| تم تعطيل نسبة الحب'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'❎| بالتأكيد تم تعطيل نسبة الحب')  
end
end
if text == 'تفعيل نسبه الرجوله' and Manager(msg) then   
if database:get(bot_id..'Cick:rjo'..msg.chat_id_)  then
database:del(bot_id..'Cick:rjo'..msg.chat_id_) 
local Text = '✅| تم تفعيل نسبه الرجولة \n\n◀️| ارسل كلمه : نسبه رجوله'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'✅| بالتأكيد تم تفعيل نسبة الرجولة')  
end
end
if text == 'تعطيل نسبه الرجوله' and Manager(msg) then  
if not database:get(bot_id..'Cick:rjo'..msg.chat_id_)  then
database:set(bot_id..'Cick:rjo'..msg.chat_id_,true) 
local Text = '❎| تم تعطيل نسبة الرجولة'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'❎| بالتأكيد تم تعطيل نسبة الرجوله')  
end
end
if text == 'تفعيل نسبه الكره' and Manager(msg) then   
if database:get(bot_id..'Cick:krh'..msg.chat_id_)  then
database:del(bot_id..'Cick:krh'..msg.chat_id_) 
local Text = '✅| تم تفعيل نسبه الكرة \n\n◀️| ارسل كلمه : نسبه الكره'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'✅| بالتأكيد تم تفعيل نسبة الكرة')  
end
end
if text == 'تعطيل نسبه الكره' and Manager(msg) then  
if not database:get(bot_id..'Cick:krh'..msg.chat_id_)  then
database:set(bot_id..'Cick:krh'..msg.chat_id_,true) 
local Text = '❎| تم تعطيل نسبة الكرة'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'❎| بالتأكيد تم تعطيل نسبة الكرة')  
end
end
if text == 'تفعيل نسبه الانوثه' and Manager(msg) then   
if database:get(bot_id..'Cick:ano'..msg.chat_id_)  then
database:del(bot_id..'Cick:ano'..msg.chat_id_) 
local Text = '✅| تم تفعيل نسبه الانوثه \n\n◀️| ارسل كلمه : نسبة الانوثة'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'✅| بالتأكيد تم تفعيل نسبة الانوثة')  
end
end
if text == 'تعطيل نسبه الانوثه' and Manager(msg) then  
if not database:get(bot_id..'Cick:ano'..msg.chat_id_)  then
database:set(bot_id..'Cick:ano'..msg.chat_id_,true) 
local Text = '❎| تم تعطيل نسبة الانوثة'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'❎| بالتأكيد تم تعطيل نسبة الانوثة')  
end
end
if text == 'تفعيل كشف الحيوان' and Manager(msg) then   
if database:get(bot_id..'Cick:ono'..msg.chat_id_)  then
database:del(bot_id..'Cick:ono'..msg.chat_id_) 
local Text = '✅| تم تفعيل كشف الحيوان \n\n◀️| ارسل كلمه : كشف الحيوان'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'✅| بالتأكيد تم تفعيل كشف الحيوان')  
end
end
if text == 'تعطيل كشف الحيوان' and Manager(msg) then  
if not database:get(bot_id..'Cick:ono'..msg.chat_id_)  then
database:set(bot_id..'Cick:ono'..msg.chat_id_,true) 
local Text = '❎| تم تعطيل كشف الحيوان'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'❎| بالتأكيد تم تعطيل كشف الحيوان')  
end
end
if text == 'تفعيل الارتباط' and Manager(msg) then   
if database:get(bot_id..'Cick:goo'..msg.chat_id_)  then
database:del(bot_id..'Cick:goo'..msg.chat_id_) 
local Text = '✅| تم تفعيل كشف الارتباط \n\n◀️| ارسل كلمه : كشف الارتباط'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'✅| بالتأكيد تم تفعيل كشف الارتباط')  
end
end
if text == 'تعطيل الارتباط' and Manager(msg) then  
if not database:get(bot_id..'Cick:goo'..msg.chat_id_)  then
database:set(bot_id..'Cick:goo'..msg.chat_id_,true) 
local Text = '❎| تم تعطيل كشف الارتباط'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'❎| بالتأكيد تم تعطيل كشف الارتباط')  
end
end
if text == 'تفعيل نسبه الغباء' and Manager(msg) then   
if database:get(bot_id..'Cick:vov'..msg.chat_id_)  then
database:del(bot_id..'Cick:vov'..msg.chat_id_) 
local Text = '✅| تم تفعيل نسبه الغباء \n\n◀️| ارسل كلمه : نسبه الغباء'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'✅| بالتأكيد تم تفعيل نسبة الغباء')  
end
end
if text == 'تعطيل نسبه الغباء' and Manager(msg) then  
if not database:get(bot_id..'Cick:vov'..msg.chat_id_)  then
database:set(bot_id..'Cick:vov'..msg.chat_id_,true) 
local Text = '❎| تم تعطيل نسبة الغباء'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'❎| بالتأكيد تم تعطيل نسبة الغباء')  
end
end
if text == 'تفعيل نسبه الزحف' and Manager(msg) then   
if database:get(bot_id..'Cick:zff'..msg.chat_id_)  then
database:del(bot_id..'Cick:zff'..msg.chat_id_) 
local Text = '✅| تم تفعيل نسبه الزحف \n\n◀️| ارسل كلمه : نسبه الزحف'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'✅| بالتأكيد تم تفعيل نسبة الزحف')  
end
end
if text == 'تعطيل نسبه الزحف' and Manager(msg) then  
if not database:get(bot_id..'Cick:zff'..msg.chat_id_)  then
database:set(bot_id..'Cick:zff'..msg.chat_id_,true) 
local Text = '❎| تم تعطيل نسبة الزحف'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'❎| بالتأكيد تم تعطيل نسبة الزحف')  
end
end
if text == 'تفعيل نسبه الخيانه' and Manager(msg) then   
if database:get(bot_id..'Cick:hen'..msg.chat_id_)  then
database:del(bot_id..'Cick:hen'..msg.chat_id_) 
local Text = '✅| تم تفعيل نسبة الخيانة \n\n◀️| ارسل كلمه : نسبة الخيانة'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'✅| بالتأكيد تم تفعيل نسبة الخيانة')  
end
end
if text == 'تعطيل نسبه الخيانه' and Manager(msg) then  
if not database:get(bot_id..'Cick:hen'..msg.chat_id_)  then
database:set(bot_id..'Cick:hen'..msg.chat_id_,true) 
local Text = '❎| تم تعطيل نسبة الخيانة'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'❎| بالتأكيد تم تعطيل نسبة الخيانة')  
end
end
------------------------------------------------------------------------
if text == 'تنزيل جميع الرتب' or text == 'تصفيه' and BasicConstructor(msg) then  
database:del(bot_id..'Constructor'..msg.chat_id_)
database:del(bot_id..'Manager'..msg.chat_id_)
database:del(bot_id..'Mod:User'..msg.chat_id_)
database:del(bot_id..'Special:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n🔖| تم تنزيل الكل من الرتب الاتيه \n\n◀️| *المميزين*/*الادمنية*/*المدراء*/*المنشئين* \n')
end
if text == "صورتي"  then
local my_ph = database:get(bot_id.."my_photo:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_,"⚠️| الصوره معطله") 
return false  
end
local function getpro(extra, result, success)
if result.photos_[0] then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[0].sizes_[1].photo_.persistent_id_,"🔢| عدد صورك -› "..result.total_count_.." صوره‌‏ 🌁", msg.id_, msg.id_, "md")
else
send(msg.chat_id_, msg.id_,'لا تمتلك صوره في حسابك', 1, 'md')
  end end
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ = msg.sender_user_id_, offset_ = 0, limit_ = 1 }, getpro, nil)
end
if text == 'تغير الايدي' and Manager(msg) then 
local List = {
[[
゠𝚄𝚂𝙴𝚁 𖨈 #username 𖥲 .
゠𝙼𝚂𝙶 𖨈 #msgs 𖥲 .
゠𝚂𝚃𝙰 𖨈 #stast 𖥲 .
゠??𝙳 𖨈 #id 𖥲 .
]],
[[
⌁ Use ⇨{#username} 
⌁ Msg⇨ {#msgs} 
⌁ Sta ⇨ {#stast} 
⌁ iD ⇨{#id} 
▿▿▿
]],
[[
- الأيـدي || {#id}.
• المُعرف || {#username}.
• الرُتبـه || {#stast}.
• الرسائل || {#msgs}.
• التـعديل || {#edit}
]],
[[
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
🇺🇸 - 𝚄𝚂𝙴𝚁 ⟿ {#username} 💘.
🇺🇸 - 𝙼𝚂𝙶𝚂 ⟿  {#msgs} 💘.
🇺🇸 - 𝙶𝙼𝙰𝚂 ⟿ {#game} 💘.
🇺🇸 - 𝙸𝙳 𝚂𝚃𝙰 ⟿ {#id} 💘.  
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
𝗖𝗛 - @TuBaKx 💘.
]],
[[
𖤂 ~ 𝑢𝑠𝑒 {#username} 𖤐
𖤂 ~ 𝑚𝑠𝑔 {#msgs} 𖤐
𖤂 ~ 𝑠𝑡𝑎 {#stast} 𖤐
𖤂 ~ 𝑖𝑑 {#id} 𖤐
𖤂 ~ 𝑒𝑑𝑖𝑡 {#edit} 𖤐
]],
[[⌔︙ᴜѕᴇʀɴᴀᴍᴇ ➥• #username .
⌔︙ᴍѕɢѕ ➥• #msgs .
⌔︙ѕᴛᴀᴛѕ ➥• #stast .
⌔︙ʏᴏᴜʀ ɪᴅ ➥• #id  .
⌔︙ᴇᴅɪᴛ ᴍsɢ ➥• #edit .
⌔︙ᴅᴇᴛᴀɪʟs ➥• #auto . 
⌔︙ɢᴀᴍᴇ ➥• #game .]],
[[
➭- 𝒔𝒕𝒂𓂅 #stast 𓍯. 💕
➮- 𝒖𝒔𝒆𝒓𓂅 #username 𓍯. 💕
➭- 𝒎𝒔𝒈𝒆𓂅 #msgs 𓍯. 💕
➭- 𝒊𝒅 𓂅 #id 𓍯. 💕
]],
[[
⚕ 𓆰 𝑾𝒆𝒍𝒄𝒐𝒎𝒆 𝑻𝒐 𝑮𝒓𝒐𝒖𝒑 ★
• 🖤 | 𝑼𝑬𝑺 : #username ‌‌‏⚚
• 🖤 | 𝑺𝑻𝑨 : #stast 🧙🏻‍♂ ☥
• 🖤 | 𝑰𝑫 : #id ‌‌‏♕
• 🖤 | 𝑴𝑺𝑮 : #msgs 𓆊
]],
[[
🖤: 𝙐𝙎𝙀??𝙉𝘼𝙈𝙀 ➱ {#username}
🖤: 𝙄𝘿 ➱ {#id}
🖤: 𝙍𝘼𝙉𝙆 ➱ {#stast}
🖤: 𝙈𝘼𝙎𝙂 ➱ {#msgs}
🖤: 𝙄𝙉𝙏𝙀𝙍𝘼𝘾𝙏 ➯ {#auto}
]],
[[
-›   𝚄𝚂𝙴𝚁𝙽𝙰𝙼𝙴 . {#username} 🇾🇪 ꙰ 
-›   𝚂𝚃𝙰𝚂𝚃 . {#stast} 🇾🇪 ꙰
-›   𝙸𝙳 . {#id} 🇾🇪 ꙰ 
-›   𝙶𝙼𝙰𝚂 . {#game} 🇾🇪 ꙰ 
-›   𝙼𝚂𝙶𝚂 . {#msgs} 🇾🇪 ꙰
]],
[[
ᯓ 𝗨𝗦𝗘𝗥𝗡𝗮𝗺𝗘 . {#username} 🇺🇸 ꙰
ᯓ 𝗦𝗧𝗮𝗦𝗧. {#stast} 🇺🇸 ꙰
ᯓ 𝗜𝗗 .  {#id} 🇺🇸 ꙰
ᯓ 𝗚𝗮𝗺𝗘𝗦 .  {#game} 🇺🇸 ꙰
ᯓ 𝗺𝗦𝗚𝗦 .  {#msgs} 🇺🇸 ꙰
]],
[[
┌ 𝐔𝐒𝐄𝐑 𖤱 #username 𖦴 .
├ 𝐌𝐒𝐆 𖤱 #msgs 𖦴 .
├ 𝐒𝐓𝐀 𖤱 #stast 𖦴 .
└ 𝐈𝐃 𖤱 #id 𖦴 .
]],
[[
𓄼🇮🇶 𝑼𝒔𝒆𝒓𝑵𝒂𝒎𝒆 :#username 
𓄼🇮🇶 𝑺𝒕𝒂𝒔𝒕 :#stast 
𓄼🇮🇶 𝒊𝒅 :#id 
𓄼🇮🇶 𝑮𝒂𝒎𝒆𝑺 :#game 
𓄼🇮🇶 𝑴𝒔𝒈𝒔 :#msgs
]],
[[
🗞¦ ʏᴏᴜʀ ɪᴅ ➺ {#id} 
🔦¦ ᴜѕᴇʀɴᴀᴍᴇ ➺ {#username} 
🕹¦ ѕᴛᴀᴛѕ ➺ {#stast} 
🔭¦ ᴅᴇᴛᴀɪʟs ➺ {#auto} 
📨¦  ᴍѕɢѕ ➺ {#msgs} 
🎰¦ ɢᴀᴍᴇ ➺ {#game}
—————
]],
[[
➞: 𝒔𝒕𝒂𓂅 #stast 𓍯➸💞.
➞: 𝒖𝒔𝒆𝒓𓂅 #username 𓍯➸💞.
➞: 𝒎𝒔𝒈𝒆𓂅 #msgs 𓍯➸💞.
➞: 𝒊𝒅 𓂅 #id 𓍯➸💞.
]],
[[
☆•𝐮𝐬𝐞𝐫 : #username 𖣬  
☆•𝐦𝐬𝐠  : #msgs 𖣬 
☆•𝐬??𝐚 : #stast 𖣬 
☆•𝐢𝐝  : #id 𖣬
]],
[[
- 𓏬 𝐔𝐬𝐄𝐫 : #username 𓂅 .
- 𓏬 𝐌𝐬𝐆  : #msgs 𓂅 .
- 𓏬 𝐒𝐭𝐀 : #stast 𓂅 .
- 𓏬 𝐈𝐃 : #id 𓂅 .
]],
[[
𖡋 𝐔𝐒𝐄 ⌯  {#username} 
𖡋 𝐌𝐒𝐆 ⌯  {#msgs} 
𖡋 𝐒𝐓𝐀 ⌯  {#stast} 
𖡋 𝐈𝐃 ⌯  {#id} 
𖡋 𝐄𝐃𝐈𝐓 ⌯  {#edit}
]]}
local Text_Rand = List[math.random(#List)]
database:set(bot_id.."KLISH:ID"..msg.chat_id_,Text_Rand)
send(msg.chat_id_, msg.id_,'🆔| تم تغير الايدي ارسل ايدي لرؤيته')
end
if text == ("ايدي") and msg.reply_to_message_id_ == 0 and not database:get(bot_id..'Bot:Id'..msg.chat_id_) then     
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da)  tdcli_function ({ ID = "SendChatAction",  chat_id_ = msg.sender_user_id_, action_ = {  ID = "SendMessageTypingAction", progress_ = 100}  },function(arg,ta)  tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)  tdcli_function ({ID = "GetUserProfilePhotos",user_id_ = msg.sender_user_id_,offset_ = 0,limit_ = 1},function(extra,ahmd,success) 
if da.status_.ID == "ChatMemberStatusCreator" then 
rtpa = 'المالك'
elseif da.status_.ID == "ChatMemberStatusEditor" then 
rtpa = 'مشرف' 
elseif da.status_.ID == "ChatMemberStatusMember" then 
rtpa = 'عضو'
end
local Msguser = tonumber(database:get(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) or 1) 
local nummsggp = tonumber(msg.id_/2097152/0.5)
local nspatfa = tonumber(Msguser / nummsggp * 100)
local Contact = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_) or 0) 
local NUMPGAME = tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_) or 0)
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
if result.username_ then
username = '@'..result.username_ 
else
username = 'لا يوجد '
end
local iduser = msg.sender_user_id_
local edit = tonumber(database:get(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_) or 0)
local photps = (ahmd.total_count_ or 0)
local interaction = Total_Msg(Msguser)
local rtpg = rtpa
local ahmda = {
"كـيك حبـيبي 😔🦋",
"عمري الحلو ☹️🍇",
"تخبل والله 💕💕",
"ئمنور حبيبي 🐨💕 ",
" شكد حلو نت 💘😒",
" صاك يعمري 🥺💘",
}
local rdphoto = ahmda[math.random(#ahmda)]
if not database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_) then      
local get_id_text = database:get(bot_id.."KLISH:ID"..msg.chat_id_)
if get_id_text then
if result.username_ then
username = '@'..result.username_ 
else
username = 'لا يوجد '
end
get_id_text = get_id_text:gsub('#rdphoto',rdphoto) 
get_id_text = get_id_text:gsub('#id',iduser) 
get_id_text = get_id_text:gsub('#username',username) 
get_id_text = get_id_text:gsub('#msgs',Msguser) 
get_id_text = get_id_text:gsub('#edit',edit) 
get_id_text = get_id_text:gsub('#stast',rtp) 
get_id_text = get_id_text:gsub('#auto',interaction) 
get_id_text = get_id_text:gsub('#game',NUMPGAME) 
get_id_text = get_id_text:gsub('#photos',photps) 
if result.status_.ID == "UserStatusRecently" and result.profile_photo_ ~= false then   
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, ahmd.photos_[0].sizes_[1].photo_.persistent_id_,get_id_text)       
else 
if result.status_.ID == "UserStatusEmpty" and result.profile_photo_ == false then
send(msg.chat_id_, msg.id_,'['..get_id_text..']')   
else
send(msg.chat_id_, msg.id_, '\n🚹| ليس لديك صور في حسابك \n['..get_id_text..']')      
end 
end
else
if result.username_ then
username = '@'..result.username_ 
else
username = 'لا يوجد '
end

if result.status_.ID == "UserStatusRecently" and result.profile_photo_ ~= false then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, ahmd.photos_[0].sizes_[1].photo_.persistent_id_,'  🌁| التعليق : '..rdphoto..'\n🏷꒐ ايديك : '..msg.sender_user_id_..'\n🚹꒐ يوزرك : '..username..'\n⏏️꒐ موقعك : '..Rutba(msg.sender_user_id_,msg.chat_id_)..'\n💭꒐ رسائلك : '..Msguser..'\n📊꒐ نسبة تفاعلك : '..string.sub(nspatfa, 1,5)..'%\n🔢| عدد صورك : '..photps..' صوره‌‏\n🗯️꒐ سحكاتك : '..edit..'\n🏆꒐ نقاطك : '..NUMPGAME..'\n⎯ ⎯ ⎯ ⎯')
else 
if result.status_.ID == "UserStatusEmpty" and result.profile_photo_ == false then
send(msg.chat_id_, msg.id_,'[\n🏷꒐ ايديك : '..msg.sender_user_id_..'\n🚹꒐ يوزرك : '..username..'\n⏏️꒐ موقعك : '..Rutba(msg.sender_user_id_,msg.chat_id_)..'\n💭꒐ رسائلك : '..Msguser..'\n📊꒐ نسبة تفاعلك : '..string.sub(nspatfa, 1,5)..'%\n🗯️꒐ سحكاتك : '..edit..'\n🏆꒐ نقاطك : '..NUMPGAME..']\n⎯ ⎯ ⎯ ⎯')
else
send(msg.chat_id_, msg.id_, '\n🌁| * ليس لديك صور في حسابك*'..'[\n🏷꒐ ايديك : '..msg.sender_user_id_..'\n🚹꒐ يوزرك : '..username..'\n⏏️꒐ موقعك : '..Rutba(msg.sender_user_id_,msg.chat_id_)..'\n💭꒐ رسائلك : '..Msguser..'\n📊꒐ نسبة تفاعلك : '..string.sub(nspatfa, 1,5)..'%\n🗯️꒐ سحكاتك : '..edit..'\n🏆꒐ نقاطك : '..NUMPGAME..']\n⎯ ⎯ ⎯ ⎯')
end 
end
end
else
local get_id_text = database:get(bot_id.."KLISH:ID"..msg.chat_id_)
if get_id_text then
get_id_text = get_id_text:gsub('#rdphoto',rdphoto) 
get_id_text = get_id_text:gsub('#id',iduser) 
get_id_text = get_id_text:gsub('#username',username) 
get_id_text = get_id_text:gsub('#msgs',Msguser) 
get_id_text = get_id_text:gsub('#edit',edit) 
get_id_text = get_id_text:gsub('#stast',rtp) 
get_id_text = get_id_text:gsub('#auto',interaction) 
get_id_text = get_id_text:gsub('#game',NUMPGAME) 
get_id_text = get_id_text:gsub('#photos',photps) 
send(msg.chat_id_, msg.id_,'['..get_id_text..']')   
else
send(msg.chat_id_, msg.id_,'[\n🏷꒐ ايديك : '..msg.sender_user_id_..'\n🚹꒐ يوزرك : '..username..'\n⏏️꒐ موقعك : '..Rutba(msg.sender_user_id_,msg.chat_id_)..'\n💭꒐ رسائلك : '..Msguser..'\n📊꒐ نسبة تفاعلك : '..string.sub(nspatfa, 1,5)..'%\n🌁| عدد صورك : '..photps..' صوره‌‏\n🗯️꒐ سحكاتك : '..edit..'\n🏆꒐ نقاطك : '..NUMPGAME..']\n⎯ ⎯ ⎯ ⎯')
end
end

end,nil)
end,nil)
end,nil)
end,nil)
end
end

if text == 'سحكاتي' or text == 'تعديلاتي' then 
local Num = tonumber(database:get(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_) or 0)
if Num == 0 then 
Text = '🚮| ليس لديك سحكات'
else
Text = '🚮| عدد سحكاتك *-› { '..Num..' } *'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == "مسح سحكاتي" or text == "حذف سحكاتي" then  
send(msg.chat_id_, msg.id_,'✅| تم مسح سحكاتك'  )  
database:del(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_)
end
if text == "مسح جهاتي" or text == "حذف جهاتي" then  
send(msg.chat_id_, msg.id_,'✅| تم مسح جهاتك'  )  
database:del(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_)
end
if text == 'جهاتي' or text == 'شكد ضفت' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local Num = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_) or 0) 
if Num == 0 then 
Text = '👤| لم تقم بأضافه احد'
else
Text = '🚻| عدد جهاتك *-› { '..Num..' } *'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == "تنظيف المشتركين" and DevTuBacK(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local pv = database:smembers(bot_id.."User_Bot")
local sendok = 0
for i = 1, #pv do
tdcli_function({ID='GetChat',chat_id_ = pv[i]
},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",  
chat_id_ = pv[i], action_ = {  ID = "SendMessageTypingAction", progress_ = 100} 
},function(arg,data) 
if data.ID and data.ID == "Ok"  then
else
database:srem(bot_id.."User_Bot",pv[i])
sendok = sendok + 1
end
if #pv == i then 
if sendok == 0 then
send(msg.chat_id_, msg.id_,'⚠️| لا يوجد مشتركين وهميين في البوت \n')   
else
local ok = #pv - sendok
send(msg.chat_id_, msg.id_,'🚻| عدد المشتركين الان -› ( '..#pv..' )\n- تم ازالة -› ( '..sendok..' ) من المشتركين\n• الان عدد المشتركين الحقيقي -› ( '..ok..' ) مشترك \n')   
end
end
end,nil)
end,nil)
end
return false
end
if text == "تنظيف الكروبات" and DevTuBacK(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local group = database:smembers(bot_id..'Chek:Groups') 
local w = 0
local q = 0
for i = 1, #group do
tdcli_function({ID='GetChat',chat_id_ = group[i]
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
database:srem(bot_id..'Chek:Groups',group[i])  
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=group[i],user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
w = w + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.code_ and data.code_ == 400 then
database:srem(bot_id..'Chek:Groups',group[i])  
w = w + 1
end
if #group == i then 
if (w + q) == 0 then
send(msg.chat_id_, msg.id_,' 🚻| لا يوجد كروبات وهميه في البوت\n')   
else
local TuBacK = (w + q)
local sendok = #group - TuBacK
if q == 0 then
TuBacK = ''
else
TuBacK = '\n- تم ازالة -› { '..q..' } كروبات من البوت'
end
if w == 0 then
TuBacKk = ''
else
TuBacKk = '\n- تم ازالة -› {'..w..'} كروب لان البوت عضو'
end
send(msg.chat_id_, msg.id_,'🚻| عدد المجموعات الان -› { '..#group..' }'..TuBacKk..''..TuBacK..'\n*↪️| الان عدد المجموعات الحقيقي -› { '..sendok..' } المجموعات\n')   
end
end
end,nil)
end
return false
end

if text and text:match("^(gpinfo)$") or text and text:match("^معلومات الكروب$") then
function gpinfo(arg,data)
-- vardump(data) 
TuBacKdx(msg.chat_id_, msg.id_, '🎟️| ايدي المجموعة -› ( '..msg.chat_id_..' )\n🚻| عدد الادمنيه -› ( *'..data.administrator_count_..' )*\n🚯| عدد المحظورين -› ( *'..data.kicked_count_..' )*\n👤| عدد الاعضاء -› ( *'..data.member_count_..' )*\n', 'md') 
end 
getChannelFull(msg.chat_id_, gpinfo, nil) 
end
-----------
if text ==("مسح") and Mod(msg) and tonumber(msg.reply_to_message_id_) > 0 then
DeleteMessage(msg.chat_id_,{[0] = tonumber(msg.reply_to_message_id_),msg.id_})   
end   
if database:get(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
database:del(bot_id..'id:user'..msg.chat_id_)  
send(msg.chat_id_, msg.id_, "✅| تم الغاء الامر ") 
database:del(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
database:del(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = database:get(bot_id..'id:user'..msg.chat_id_)  
database:del(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) 
database:incrby(bot_id..'Msg_User'..msg.chat_id_..':'..iduserr,numadded)  
send(msg.chat_id_, msg.id_,"📩| تم اضافة له {"..numadded..'} من الرسائل')  
end
------------------------------------------------------------------------
if database:get(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
database:del(bot_id..'idgem:user'..msg.chat_id_)  
send(msg.chat_id_, msg.id_, "⏏️| تم الغاء الامر ") 
database:del(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
database:del(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = database:get(bot_id..'idgem:user'..msg.chat_id_)  
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..iduserr,numadded)  
send(msg.chat_id_, msg.id_,  1, "🔢| تم اضافة له {"..numadded..'} من النقود', 1 , 'md')  
end
------------------------------------------------------------
if text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id_ == 0 and Constructor(msg) then    
ahmd = text:match("^اضف رسائل (%d+)$")
database:set(bot_id..'id:user'..msg.chat_id_,ahmd)  
database:setex(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_, '↪️| ارسل لي عدد الرسائل الان') 
return false
end
------------------------------------------------------------------------
if text and text:match("^اضف نقاط (%d+)$") and msg.reply_to_message_id_ == 0 and Constructor(msg) then  
ahmd = text:match("^اضف نقاط (%d+)$")
database:set(bot_id..'idgem:user'..msg.chat_id_,ahmd)  
database:setex(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_, '↪️| ارسل لي عدد النقاط التي تريد اضافتها') 
return false
end
------------------------------------------------------------------------
if text and text:match("^اضف نقاط (%d+)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
local Num = text:match("^اضف نقاط (%d+)$")
function reply(extra, result, success)
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..result.sender_user_id_,Num)  
send(msg.chat_id_, msg.id_,"🔢| تم اضافة له {"..Num..'} من النقاط')  
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},reply, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
local Num = text:match("^اضف رسائل (%d+)$")
function reply(extra, result, success)
database:del(bot_id..'Msg_User'..msg.chat_id_..':'..result.sender_user_id_) 
database:incrby(bot_id..'Msg_User'..msg.chat_id_..':'..result.sender_user_id_,Num)  
send(msg.chat_id_, msg.id_, "\n🔢| تم اضافة له {"..Num..'} من الرسائل')  
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},reply, nil)
return false
end
if text == 'نقاط' or text == 'نقاطي' then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local Num = database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_) or 0
if Num == 0 then 
Text = '⏺️| لم تلعب اي لعبه للحصول على نقاط'
else
Text = '🎁| عدد نقاطك التي ربحتها هيه *-› { '..Num..' } نقاط *'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text and text:match("^بيع نقاطي (%d+)$") or text and text:match("^بيع نقاط (%d+)$") then
local NUMPY = text:match("^بيع نقاطي (%d+)$") or text and text:match("^بيع نقاط (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if tonumber(NUMPY) == tonumber(0) then
send(msg.chat_id_,msg.id_,"\n*👤| لا استطيع البيع اقل من 1 *") 
return false 
end
if tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_)) == tonumber(0) then
send(msg.chat_id_,msg.id_,'🚸| ليس لديك نقاط في الالعاب\n🎁| اذا كنت تريد ربح نقاط \n↩️| ارسل الالعاب وابدأ اللعب ! ') 
else
local NUM_GAMES = database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_)
if tonumber(NUMPY) > tonumber(NUM_GAMES) then
send(msg.chat_id_,msg.id_,'\n🚸| ليس لديك نقاط في هذه لعبه \n🔢| لزيادة نقاطك في اللعبه \n🚺| ارسل الالعاب وابدأ اللعب !') 
return false 
end
local NUMNKO = (NUMPY * 50)
database:decrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_,NUMPY)  
database:incrby(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_,NUMNKO)  
send(msg.chat_id_,msg.id_,'▶️| تم خصم *-› { '..NUMPY..' }* من نقاطك \n🔢| وتم اضافة* -› { '..(NUMPY * 50)..' } رساله الى رسالك *')
end 
return false 
end
if text == 'فحص البوتت' and Manager(msg) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. msg.chat_id_ ..'&user_id='.. bot_id..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.status == "administrator" then
if Json_Info.result.can_change_info == true then
info = '✔️' else info = '✖' end
if Json_Info.result.can_delete_messages == true then
delete = '✔️' else delete = '✖' end
if Json_Info.result.can_invite_users == true then
invite = '✔️' else invite = '✖' end
if Json_Info.result.can_pin_messages == true then
pin = '✔️' else pin = '✖' end
if Json_Info.result.can_restrict_members == true then
restrict = '✔️' else restrict = '✖' end
if Json_Info.result.can_promote_members == true then
promote = '✔️' else promote = '✖' end 
send(msg.chat_id_,msg.id_,'\n🚺| اهلا عزيزي البوت هنا ادمن'..'\n↪️| وصلاحياته هي ↓ \nٴ━━━━━━━━━━'..'\n🚸| تغير معلومات المجموعة ‹- ❴ '..info..' ❵'..'\n📩| حذف الرسائل ‹- ❴ '..delete..' ❵'..'\n🚯| حظر المستخدمين ‹- ❴ '..restrict..' ❵'..'\n👥| دعوة مستخدمين ‹- ❴ '..invite..' ❵'..'\n💭| تثبيت الرسائل ‹- ❴ '..pin..' ❵'..'\n🛡️| اضافة مشرفين جدد ‹- ❴ '..promote..' ❵')   
end
end
end


if text and text:match("^تغير رد المطور (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رد المطور (.*)$") 
database:set(bot_id.."Sudo:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"🚹| تم تغير رد المطور الى -› "..Teext)
end
if text and text:match("^تغير رد المالك (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رد المالك (.*)$") 
database:set(bot_id.."CoSu:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"🚹| تم تغير رد المالك الى -› "..Teext)
end
if text and text:match("^تغير رد منشئ الاساسي (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رد منشئ الاساسي (.*)$") 
database:set(bot_id.."BasicConstructor:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"🚹| تم تغير رد المنشئ الاساسي الى -› "..Teext)
end
if text and text:match("^تغير رد المنشئ (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رد المنشئ (.*)$") 
database:set(bot_id.."Constructor:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"🚹| تم تغير رد المنشئ الى -› "..Teext)
end
if text and text:match("^تغير رد المدير (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رد المدير (.*)$") 
database:set(bot_id.."Manager:Rd"..msg.chat_id_,Teext) 
send(msg.chat_id_, msg.id_,"🚹| تم تغير رد المدير الى -› "..Teext)
end
if text and text:match("^تغير رد الادمن (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رد الادمن (.*)$") 
database:set(bot_id.."Mod:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"🚹| تم تغير رد الادمن الى -› "..Teext)
end
if text and text:match("^تغير رد المميز (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رد المميز (.*)$") 
database:set(bot_id.."Special:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"🚹| تم تغير رد المميز الى -› "..Teext)
end
if text and text:match("^تغير رد العضو (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رد العضو (.*)$") 
database:set(bot_id.."Memp:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"🚹| تم تغير رد العضو الى -› "..Teext)
end

if text and text:match("^(.*)$") then
if database:get(bot_id..'help'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '✅| تم حفظ الكليشه')
database:del(bot_id..'help'..msg.sender_user_id_)
database:set(bot_id..'help_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help1'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '✅| تم حفظ الكليشه')
database:del(bot_id..'help1'..msg.sender_user_id_)
database:set(bot_id..'help1_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help2'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '✅| تم حفظ الكليشه')
database:del(bot_id..'help2'..msg.sender_user_id_)
database:set(bot_id..'help2_text',text)
return false
end
end

if text and text:match("^(.*)$") then
if database:get(bot_id..'help3'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '✅| تم حفظ الكليشه')
database:del(bot_id..'help3'..msg.sender_user_id_)
database:set(bot_id..'help3_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help4'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '✅| تم حفظ الكليشه')
database:del(bot_id..'help4'..msg.sender_user_id_)
database:set(bot_id..'help4_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help5'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '✅| تم حفظ الكليشه')
database:del(bot_id..'help5'..msg.sender_user_id_)
database:set(bot_id..'help5_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help6'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '✅| تم حفظ الكليشه')
database:del(bot_id..'help6'..msg.sender_user_id_)
database:set(bot_id..'help6_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help6'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '✅| تم حفظ الكليشه')
database:del(bot_id..'help6'..msg.sender_user_id_)
database:set(bot_id..'help6_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help7'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '✅| تم حفظ الكليشه')
database:del(bot_id..'help7'..msg.sender_user_id_)
database:set(bot_id..'help7_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help5'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '✅| تم حفظ الكليشه')
database:del(bot_id..'help5'..msg.sender_user_id_)
database:set(bot_id..'help5_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help7'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '✅| تم حفظ الكليشه')
database:del(bot_id..'help7'..msg.sender_user_id_)
database:set(bot_id..'help7_text',text)
return false
end
end

if text == 'استعاده الاوامر' and DevTuBacK(msg) then
database:del(bot_id..'help_text')
database:del(bot_id..'help1_text')
database:del(bot_id..'help2_text')
database:del(bot_id..'help3_text')
database:del(bot_id..'help4_text')
database:del(bot_id..'help5_text')
database:del(bot_id..'help6_text')
database:del(bot_id..'help6_text')
database:del(bot_id..'help7_text')
database:del(bot_id..'help5_text')
database:del(bot_id..'help7_text')
send(msg.chat_id_, msg.id_, '↪️| تم استعادة الاوامر القديمه')
end
if text == 'تغير امر الاوامر' and DevTuBacK(msg) then
send(msg.chat_id_, msg.id_, '↪️| الان يمكنك ارسال الكليشه الاوامر')
database:set(bot_id..'help'..msg.sender_user_id_,'true')
return false 
end
if text == 'تغير امر م1' and DevTuBacK(msg) then
send(msg.chat_id_, msg.id_, '↪️| الان يمكنك ارسال الكليشه م1')
database:set(bot_id..'help1'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م2' and DevTuBacK(msg) then
send(msg.chat_id_, msg.id_, '↪️| الان يمكنك ارسال الكليشه م2')
database:set(bot_id..'help2'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م3' and DevTuBacK(msg) then
send(msg.chat_id_, msg.id_, '↪️| الان يمكنك ارسال الكليشه م3')
database:set(bot_id..'help3'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م4' and DevTuBacK(msg) then
send(msg.chat_id_, msg.id_, '↪️| الان يمكنك ارسال الكليشه م4')
database:set(bot_id..'help4'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م5' and DevTuBacK(msg) then
send(msg.chat_id_, msg.id_, '↪️| الان يمكنك ارسال الكليشه م5')
database:set(bot_id..'help5'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م6' and DevTuBacK(msg) then
send(msg.chat_id_, msg.id_, '↪️| الان يمكنك ارسال الكليشه م6')
database:set(bot_id..'help6'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م7' and DevTuBacK(msg) then
send(msg.chat_id_, msg.id_, '↪️| الان يمكنك ارسال الكليشه م7')
database:set(bot_id..'help7'..msg.sender_user_id_,'true')
return false 
end

if text == 'الاوامر' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'⚠️| هاذا الامر خاص بالادمنيه\n🔽| ارسل {م10} لعرض اوامر الاعضاء')
return false
end
local url,res = https.request('https://anashtick.ml/TuBak.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.TuBak ~= true then
local inline = {{{text="اضغط هنا للشتراك 🚹",url="https://t.me/TuBakx"}}}
SendInline(msg.chat_id_,'عذراً عليك الاشتراك في [. Team TuBak](t.me/TuBaKx) \nليمكنك استخدام البوت بشكل كامل',nil,inline)
return false 
end
local Text =[[
*اهلا بك في سورس* [. TuBak Team](t.me/Tubakx)
*يمكنك استخدام الاوامر الموجودة 🔽*
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'آوآمر آلحماية', callback_data="/help1"},{text = 'آوآمر آلادمنية ⁦', callback_data="/help2"},
},
{
{text = 'آوآمر آلمدرآء', callback_data="/help3"},{text = 'آوآمر آلمنشئين', callback_data="/help4"},
},
{
{text = 'آوآمر آلمطورين', callback_data="/help5"},
},
{
{text = 'آوآمر آلخدمية', callback_data="/help6"},{text = 'آوآمر آلاعضاء', callback_data="/help7"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end
----------------------------------------------------------------------------
if text == "شنو رئيك بهذا" or text == "شنو رئيك بهذ" or text == "شنو رئيج بهذ" or text == "شنو رئيج بهذا" or text == "شنو رايك بهذا" or text == "شنو رايك بهذ" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"ادب سسز يباوع علي بنات 😂🥺"," مو خوش ولد 😶","زاحف وما احبه 😾😹"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "شنو رئيك بهاي" or text == "شنو رئيك بهايي" or text == "شنو رئيج بهايي" or text == "شنو رئيج بهاي" or text == "شنو رايك بهاي" or text == "شنو رايك بهايي" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"دور حلوين 🤕😹","جكمه وصخه عوفها ☹️😾","حقيره ومنتكبره 😶😂"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "هينه" or text == "رزله" or text == "هيني" or text == "رزلي" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"ولك هيو لتندك بسيادك لو بهاي 👞👈","ميستاهل اتعبي روحي ويا لانه عار","عوفه يروحي هاذا طيز يضل يمضرط🤣"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "مصه" or text == "بوسه" or text == "بوسي" or text == "مصي" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"مووووووووواححح💋","مابوس ولي😌😹","خدك/ج نضيف 😂","البوسه بالف حمبي 🌝💋","خلي يزحفلي وابوسه 🙊😻","كل شويه ابوسه كافي 😏","ماابوسه والله هذا زاحف🦎","محح هاي لحاته صاكه💋"}send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text and text:match('^الحساب (%d+)$') then
local id = text:match('^الحساب (%d+)$')
local text = 'اضغط لمشاهده الحساب'
tdcli_function ({ID="SendMessage", chat_id_=msg.chat_id_, reply_to_message_id_=msg.id_, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=19, user_id_=id}}}}, dl_cb, nil)
end
local function oChat(chat_id,cb)
tdcli_function ({
ID = "OpenChat",
chat_id_ = chat_id
}, cb, nil)
end
if text == "صلاحياته" and tonumber(msg.reply_to_message_id_) > 0 then    
if tonumber(msg.reply_to_message_id_) ~= 0 then 
function prom_reply(extra, result, success) 
Get_Info(msg,msg.chat_id_,result.sender_user_id_)
end  
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},prom_reply, nil)
end
end
------------------------------------------------------------------------
if text == "صلاحياتي" then 
if tonumber(msg.reply_to_message_id_) == 0 then 
Get_Info(msg,msg.chat_id_,msg.sender_user_id_)
end  
end
------------------------------------------------------------------------
if text and text:match('^صلاحياته @(.*)') then   
local username = text:match('صلاحياته @(.*)')   
if tonumber(msg.reply_to_message_id_) == 0 then 
function prom_username(extra, result, success) 
if (result and result.code_ == 400 or result and result.message_ == "USERNAME_NOT_OCCUPIED") then
SendText(msg.chat_id_,msg.id_,"⚠️| المعرف غير صحيح \n*")   
return false  end   

Get_Info(msg,msg.chat_id_,result.id_)
end  
tdcli_function ({ID = "SearchPublicChat",username_ = username},prom_username,nil) 
end 
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end -- Chat_Type = 'GroupBot' 
end -- end msg 
--------------------------------------------------------------------------------------------------------------
function tdcli_update_callback(data)  -- clback
if data.ID == "UpdateChannel" then 
if data.channel_.status_.ID == "ChatMemberStatusKicked" then 
database:srem(bot_id..'Chek:Groups','-100'..data.channel_.id_)  
end
end
if data.ID == "UpdateNewCallbackQuery" then
local Chat_id = data.chat_id_
local Msg_id = data.message_id_
local msg_idd = Msg_id/2097152/0.5
local Text = data.payload_.data_
if Text == '/help' then
if not Mod(data) then
local notText = '⚠️| عذرا عزيزي الامر ليس لك ؟'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
*اهلا بك في سورس* [. TuBak Team](t.me/Tubakx)
*يمكنك استخدام الاوامر الموجودة 🔽*
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'آوآمر آلحماية', callback_data="/help1"},{text = 'آوآمر آلادمنية ⁦', callback_data="/help2"},
},
{
{text = 'آوآمر آلمدرآء', callback_data="/help3"},{text = 'آوآمر آلمنشئين', callback_data="/help4"},
},
{
{text = 'آوآمر آلمطورين', callback_data="/help5"},
},
{
{text = 'آوآمر آلخدمية', callback_data="/help6"},{text = 'آوآمر آلاعضاء', callback_data="/help7"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help1' then
if not Mod(data) then
local notText = '⚠️| عذرا عزيزي الامر ليس لك ؟'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
📋| *اوامر حماية المجموعة*

• قفل + فتح ← الامر… 
• ← { بالتقيد ، بالطرد ، بالكتم }
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
• الروابط
• المعرف
• التاك
• الشارحه
• التعديل
• التثبيت
• المتحركه
• الملفات
• الصور
• التفليش
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
• الماركداون
• البوتات
• الاباحي
• التكرار
• الكلايش
• السيلفي
• الملصقات
• الفيديو
• الانلاين
• الدردشه
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
• التوجيه
• الاغاني
• الصوت
• الجهات
• الاشعارات
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
🚹| [Source Tubak . ](t.me/Tubakx)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'آوآمر آلحماية', callback_data="/help1"},{text = 'آوآمر آلادمنية ⁦', callback_data="/help2"},
},
{
{text = 'آوآمر آلمدرآء', callback_data="/help3"},{text = 'آوآمر آلمنشئين', callback_data="/help4"},
},
{
{text = 'آوآمر آلمطورين', callback_data="/help5"},
},
{
{text = 'آوآمر آلخدمية', callback_data="/help6"},{text = 'آوآمر آلاعضاء', callback_data="/help7"},
},
{
{text = 'رجوع', callback_data="/help"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help2' then
if not Mod(data) then
local notText = '⚠️| عذرا عزيزي الامر ليس لك ؟'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
📋| *اوامر الادمنيه ↓*
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
• اوامر تفعيل وتعطيل 
• تفعيل ~ تعطيل + امر 
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
• اطردني
• صيح
• ضافني
• الرابط 
• الحظر
• الرفع
• الايدي
• الالعاب
• ردود المطور
• ردود البوت
• الترحيب
• ردود المدير
• ٴall
• الردود
• نسبة الحب
• نسبة الرجوله
• نسبه الانوثه 
• نسبه الكره
• حساب العمر
• الابراج
• تنبيه الاسماء
• تنبيه المعرف
• تنبيه الصور
• التوحيد
• الكتم الاسم
• زخرفه
• ردود البوت
• اوامر التحشيش
• صورتي 
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
🚹| [Source Tubak . ](t.me/Tubakx)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'آوآمر آلحماية', callback_data="/help1"},{text = 'آوآمر آلادمنية ⁦', callback_data="/help2"},
},
{
{text = 'آوآمر آلمدرآء', callback_data="/help3"},{text = 'آوآمر آلمنشئين', callback_data="/help4"},
},
{
{text = 'آوآمر آلمطورين', callback_data="/help5"},
},
{
{text = 'آوآمر آلخدمية', callback_data="/help6"},{text = 'آوآمر آلاعضاء', callback_data="/help7"},
},
{
{text = 'رجوع', callback_data="/help"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help3' then
if not Mod(data) then
local notText = '⚠️| عذرا عزيزي الامر ليس لك ؟'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
📋| *اوامر المدراء ↓*
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
• اضف / حذف ← رد
• اضف / حذف ← صلاحيه
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
• ضع + امر …
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
• اسم
• رابط
• ترحيب
• قوانين
• رد متعدد 
• صوره
• وصف
• تكرار + عدد
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
• يمكنك تفعيل وتعطيل الاوامر التالية ↓↑

• تفعيل / تعطيل نسبه الحب
• تفعيل / تعطيل نسبه الكره
• تفعيل / تعطيل نسبه الانوثه
• تفعيل / تعطيل نسبه رجوله
• تفعيل / تعطيل نسبه الزحف
• تفعيل / تعطيل نسبه الغباء
• تفعيل / تعطيل كشف الارتباط
• تفعيل / تعطيل كشف الحيوان
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
🚹| [Source Tubak . ](t.me/Tubakx)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'آوآمر آلحماية', callback_data="/help1"},{text = 'آوآمر آلادمنية ⁦', callback_data="/help2"},
},
{
{text = 'آوآمر آلمدرآء', callback_data="/help3"},{text = 'آوآمر آلمنشئين', callback_data="/help4"},
},
{
{text = 'آوآمر آلمطورين', callback_data="/help5"},
},
{
{text = 'آوآمر آلخدمية', callback_data="/help6"},{text = 'آوآمر آلاعضاء', callback_data="/help7"},
},
{
{text = 'رجوع', callback_data="/help"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help4' then
if not Mod(data) then
local notText = '⚠️| عذرا عزيزي الامر ليس لك ؟ '
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
📋| *اوامر المنشئين ↓*
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
• مسح + امر ↓
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯

• اوامر التغير …
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
• تغير رد المطور + اسم
• تغير رد المالك + اسم
• تغير رد منشئ الاساسي + اسم
• تغير رد المنشئ + اسم
• تغير رد المدير + اسم
• تغير رد الادمن + اسم
• تغير رد المميز + اسم
• تغير رد العضو + اسم
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
• الايدي 
• المميزين
• الادمنيه
• المدراء
• المنشئين
• الاساسين
• الاسماء المكتومه
• ردود المدير
• البوتات
• امسح
• صلاحيه
• قائمه منع المتحركات
• قائمه منع الصور
• قائمه منع الملصقات
• مسح قائمه المنع
• المحذوفين
• كشف القيود
• تعين الايدي
• تغير الايدي
• الحساب + ايدي الحساب
• تنظيف + العدد
• تنزيل الكل
• تنزيل جميع الرتب
• منع + برد
• ~ الصور + متحركه + ملصق ~
• حظر ~ كتم ~ تقيد ~ طرد
• المحظورين ~ المكتومين ~ المقيدين
• الغاء كتم + حظر + تقيد ~ بالرد و معرف و ايدي
• تقيد ~ كتم + الرقم + ساعه
• تقيد ~ كتم + الرقم + يوم
• تقيد ~ كتم + الرقم + دقيقه
• تثبيت ~ الغاء تثبيت
• الترحيب
• الغاء تثبيت الكل
• كشف البوتات
• الصلاحيات
• كشف ~ برد ← بمعرف ← ايدي
• تاك للكل
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
• حذف  امر + الامر القديم  
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
• الاوامر المضافه ( لعرض الاوامر المضافه ) 
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
🚹| [Source Tubak . ](t.me/Tubakx)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'آوآمر آلحماية', callback_data="/help1"},{text = 'آوآمر آلادمنية ⁦', callback_data="/help2"},
},
{
{text = 'آوآمر آلمدرآء', callback_data="/help3"},{text = 'آوآمر آلمنشئين', callback_data="/help4"},
},
{
{text = 'آوآمر آلمطورين', callback_data="/help5"},
},
{
{text = 'آوآمر آلخدمية', callback_data="/help6"},{text = 'آوآمر آلاعضاء', callback_data="/help7"},
},
{
{text = 'رجوع', callback_data="/help"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help5' then
if not Sudo(data) then
local notText = '🗣️| عذراً الامر للمطور فقط ؟'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
📋| *اوامر المطور الاساسي ↓*
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯

• تفعيل ← تعطيل 
• المجموعات ← المشتركين ← الاحصائيات
• رفع ← تنزيل منشئ اساسي
• مسح الاساسين ← المنشئين الاساسين
• مسح المنشئين ← المنشئين
• اسم ~ ايدي + بوت غادر 
• اذاعه 

• تفعيل
• تعطيل
• مسح الاساسين
• المنشئين الاساسين
• رفع/تنزيل منشئ اساسي
• رفع/تنزيل مطور اساسي 
• مسح المطورين
• المطورين
• رفع | تنزيل مطور
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
• اسم البوت + غادر
• غادر
• اسم بوت + الرتبه
• تحديث السورس
• حضر عام
• كتم عام
• الغاء العام
• قائمه العام
• مسح قائمه العام
• جلب نسخه الاحتياطيه
• رفع نسخه الاحتياطيه
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
• المتجر 
• متجر الملفات
• الملفات
• مسح الملفات
• تعطيل + تفعيل + اسم ملف
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
• اذاعه خاص
• اذاعه
• اذاعه بالتوجيه
• اذاعه بالتوجيه خاص
• اذاعه بالتثبيت
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
• جلب نسخه البوت
• رفع نسخه البوت
• ضع عدد الاعضاء + العدد
• ضع كليشه المطور
• تفعيل/تعطيل الاذاعه
• تفعيل/تعطيل البوت الخدمي
• تفعيل/تعطيل التواصل
• تغير اسم البوت
• اضف/حذف رد للكل
• ردود المطور
• مسح ردود المطور
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
• الاشتراك الاجباري
• تعطيل الاشتراك الاجباري
• تفعيل الاشتراك الاجباري
• حذف رساله الاشتراك
• تغير رساله الاشتراك 
• تغير الاشتراك 
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
• الاحصائيات
• المشتركين
• المجموعات 
• تفعيل/تعطيل المغادره
• تنظيف المشتركين
• تنظيف الكروبات
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
🚹| [Source Tubak . ](t.me/Tubakx)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'آوآمر آلحماية', callback_data="/help1"},{text = 'آوآمر آلادمنية ⁦', callback_data="/help2"},
},
{
{text = 'آوآمر آلمدرآء', callback_data="/help3"},{text = 'آوآمر آلمنشئين', callback_data="/help4"},
},
{
{text = 'آوآمر آلمطورين', callback_data="/help5"},
},
{
{text = 'آوآمر آلخدمية', callback_data="/help6"},{text = 'آوآمر آلاعضاء', callback_data="/help7"},
},
{
{text = 'رجوع', callback_data="/help"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help6' then
if not Mod(data) then
local notText = '⚠️| عذرا عزيزي الامر ليس لك ؟'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
📋| *الاوامر الخدمية ↓*
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
• تفعيل - تعطيل التحويل
• تحويل ~ صوره - ملصق - بصمه ..
• استعاده الاوامر 
• وضع لقب + لقب
• حذف لقب بالرد
• اعدادات المجموعه
• ردود المدير
• اسم بوت + الرتبه
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
• نسبه الحب 
• نسبه رجوله
• نسبه الكره
• نسبه الانوثه
• نسبه الزحف
• نسبه الغباء
• كشف الارتباط
• كشف الحيوان
• الساعه
• التاريخ
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
🚹| [Source Tubak . ](t.me/Tubakx)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'آوآمر آلحماية', callback_data="/help1"},{text = 'آوآمر آلادمنية ⁦', callback_data="/help2"},
},
{
{text = 'آوآمر آلمدرآء', callback_data="/help3"},{text = 'آوآمر آلمنشئين', callback_data="/help4"},
},
{
{text = 'آوآمر آلمطورين', callback_data="/help5"},
},
{
{text = 'آوآمر آلخدمية', callback_data="/help6"},{text = 'آوآمر آلاعضاء', callback_data="/help7"},
},
{
{text = 'رجوع', callback_data="/help"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/help7' then
local help_text = database:get(bot_id..'help7_text')
local Teext =[[
📋| *اوامر الاعضاء ↓*
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
• عرض معلوماتك ↑↓
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
• ايديي ← اسمي 
• رسايلي ← مسح رسايلي 
• رتبتي ← سحكاتي 
• مسح سحكاتي ← المنشئ 
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
• اوآمر المجموعه ↑↓
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
• الرابط ← القوانين – الترحيب
• ايدي ← اطردني 
• اسمي ← المطور  
• كشف ~ بالرد بالمعرف
• كول + كلمه
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
• اسم البوت + الامر ↑↓
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
• بوسه بالرد 
• مصه بالرد
• رزله بالرد 
• شنو رئيك بهذا بالرد
• شنو رئيك بهاي بالرد
• تحب هذا
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
• نسبه الحب
• نسبه الكره
• نسبه الانوثه
• نسبه رجوله
• نسبه الزحف
• نسبه الغباء
• كشف الارتباط
• كشف الحيوان
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
🚹| [Source Tubak . ](t.me/Tubakx)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'آوآمر آلحماية', callback_data="/help1"},{text = 'آوآمر آلادمنية ⁦', callback_data="/help2"},
},
{
{text = 'آوآمر آلمدرآء', callback_data="/help3"},{text = 'آوآمر آلمنشئين', callback_data="/help4"},
},
{
{text = 'آوآمر آلمطورين', callback_data="/help5"},
},
{
{text = 'آوآمر آلخدمية', callback_data="/help6"},{text = 'آوآمر آلاعضاء', callback_data="/help7"},
},
{
{text = 'رجوع', callback_data="/help"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
end
if data.ID == "UpdateNewMessage" then  -- new msg
msg = data.message_
text = msg.content_.text_
--------------------------------------------------------------------------------------------------------------
if text and not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
database:del(bot_id..'Spam:Texting'..msg.sender_user_id_) 
end
--------------------------------------------------------------------------------------------------------------
if text and database:get(bot_id.."Del:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_) == 'true' then
local NewCmmd = database:get(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..text)
if NewCmmd then
database:del(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..text)
database:del(bot_id.."Set:Cmd:Group:New"..msg.chat_id_)
database:srem(bot_id.."List:Cmd:Group:New"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,'✅| تم حذف الامر')  
else
send(msg.chat_id_, msg.id_,'⚠️| لا يوجد امر بهاذا الاسم')  
end
database:del(bot_id.."Del:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_)
return false
end 
-------------------------------------------------------------------------------------------------------------- 
if data.message_.content_.text_ then
local NewCmmd = database:get(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..data.message_.content_.text_)
if NewCmmd then
data.message_.content_.text_ = (NewCmmd or data.message_.content_.text_)
end
end

if text == 'السمايلات' or text == 'السمايل' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا \n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Games'..msg.chat_id_) then
database:del(bot_id..'Set:Sma'..msg.chat_id_)
Random = {'🍏','🍎','🍐','🍊','??','🍉','🍇','🍓','??','🍒','🍑','🍍','??','🥝','🍅','🍆','🥑','🥦','🥒','🌶','🌽','🥕','🥔','🥖','🥐','🍞','🥨','🍟','🧀','🥚','🍳','🥓','🥩','🍗','🍖','🌭','🍔','🍠','🍕','🥪','🥙','☕️','🍵','🥤','🍶','🍺','🍻','🏀','⚽️','🏈','⚾️','🎾','🏐','🏉','🎱','🏓','🏸','🥅','🎰','🎮','🎳','🎯','🎲','🎻','🎸','🎺','🥁','🎹','🎼','🎧','🎤','🎬','🎨','🎭','🎪','🎟','🎫','🎗','🏵','🎖','🏆','🥌','🛷','🚗','🚌','🏎','🚓','🚑','🚚','🚛','🚜','🇮🇶','⚔','🛡','🔮','🌡','💣','📌','📍','📓','📗','📂','📅','📪','📫','📬','📭','⏰','📺','🎚','☎️','📡'}
SM = Random[math.random(#Random)]
database:set(bot_id..'Random:Sm'..msg.chat_id_,SM)
send(msg.chat_id_, msg.id_,'🎊| اسرع واحد يدز هاذا السمايل ? -› {`'..SM..'`}')
return false
end
end
if text == ''..(database:get(bot_id..'Random:Sm'..msg.chat_id_) or '')..'' and not database:get(bot_id..'Set:Sma'..msg.chat_id_) then
if not database:get(bot_id..'Set:Sma'..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'🎗️| الف مبروك لقد فزت \n🎁| للعب مره اخره ارسل -›{ سمايل , سمايلات }')
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
database:set(bot_id..'Set:Sma'..msg.chat_id_,true)
return false
end 
if text == 'اسرع' or text == 'الاسرع' or text == 'ترتيب' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا \n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Games'..msg.chat_id_) then
database:del(bot_id..'Speed:Tr'..msg.chat_id_)
KlamSpeed = {'سحور','سياره','استقبال','قنفه','ايفون','بزونه','مطبخ','كرستيانو','دجاجه','مدرسه','الوان','غرفه','ثلاجه','كهوه','سفينه','العراق','محطه','طياره','رادار','منزل','مستشفى','كهرباء','تفاحه','اخطبوط','سلمون','فرنسا','برتقاله','تفاح','مطرقه','بتيته','لهانه','شباك','باص','سمكه','ذباب','تلفاز','حاسوب','انترنيت','ساحه','جسر'};
name = KlamSpeed[math.random(#KlamSpeed)]
database:set(bot_id..'Klam:Speed'..msg.chat_id_,name)
name = string.gsub(name,'سحور','س ر و ح')
name = string.gsub(name,'سياره','ه ر س ي ا')
name = string.gsub(name,'استقبال','ل ب ا ت ق س ا')
name = string.gsub(name,'قنفه','ه ق ن ف')
name = string.gsub(name,'ايفون','و ن ف ا')
name = string.gsub(name,'بزونه','ز و ه ن')
name = string.gsub(name,'مطبخ','خ ب ط م')
name = string.gsub(name,'كرستيانو','س ت ا ن و ك ر ي')
name = string.gsub(name,'دجاجه','ج ج ا د ه')
name = string.gsub(name,'مدرسه','ه م د ر س')
name = string.gsub(name,'الوان','ن ا و ا ل')
name = string.gsub(name,'غرفه','غ ه ر ف')
name = string.gsub(name,'ثلاجه','ج ه ت ل ا')
name = string.gsub(name,'كهوه','ه ك ه و')
name = string.gsub(name,'سفينه','ه ن ف ي س')
name = string.gsub(name,'العراق','ق ع ا ل ر ا')
name = string.gsub(name,'محطه','ه ط م ح')
name = string.gsub(name,'طياره','ر ا ط ي ه')
name = string.gsub(name,'رادار','ر ا ر ا د')
name = string.gsub(name,'منزل','ن ز م ل')
name = string.gsub(name,'مستشفى','ى ش س ف ت م')
name = string.gsub(name,'كهرباء','ر ب ك ه ا ء')
name = string.gsub(name,'تفاحه','ح ه ا ت ف')
name = string.gsub(name,'اخطبوط','ط ب و ا خ ط')
name = string.gsub(name,'سلمون','ن م و ل س')
name = string.gsub(name,'فرنسا','ن ف ر س ا')
name = string.gsub(name,'برتقاله','ر ت ق ب ا ه ل')
name = string.gsub(name,'تفاح','ح ف ا ت')
name = string.gsub(name,'مطرقه','ه ط م ر ق')
name = string.gsub(name,'بتيته','ب ت ت ي ه')
name = string.gsub(name,'لهانه','ه ن ل ه ل')
name = string.gsub(name,'شباك','ب ش ا ك')
name = string.gsub(name,'باص','ص ا ب')
name = string.gsub(name,'سمكه','ك س م ه')
name = string.gsub(name,'ذباب','ب ا ب ذ')
name = string.gsub(name,'تلفاز','ت ف ل ز ا')
name = string.gsub(name,'حاسوب','س ا ح و ب')
name = string.gsub(name,'انترنيت','ا ت ن ر ن ي ت')
name = string.gsub(name,'ساحه','ح ا ه س')
name = string.gsub(name,'جسر','ر ج س')
send(msg.chat_id_, msg.id_,'🎁| اسرع واحد يرتبها -› {'..name..'}')
return false
end
end
------------------------------------------------------------------------
if text == ''..(database:get(bot_id..'Klam:Speed'..msg.chat_id_) or '')..'' and not database:get(bot_id..'Speed:Tr'..msg.chat_id_) then
if not database:get(bot_id..'Speed:Tr'..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'🎗️| الف مبروك لقد فزت \n🎁| للعب مره اخره ارسل -›{ الاسرع , ترتيب }')
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
database:set(bot_id..'Speed:Tr'..msg.chat_id_,true)
end 

if text == 'الحزوره' or text == 'حزوره' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا \n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Games'..msg.chat_id_) then
database:del(bot_id..'Set:Hzora'..msg.chat_id_)
Hzora = {'الجرس','عقرب الساعه','السمك','المطر','5','الكتاب','البسمار','7','الكعبه','بيت الشعر','لهانه','انا','امي','الابره','الساعه','22','غلط','كم الساعه','البيتنجان','البيض','المرايه','الضوء','الهواء','الضل','العمر','القلم','المشط','الحفره','البحر','الثلج','الاسفنج','الصوت','بلم'};
name = Hzora[math.random(#Hzora)]
database:set(bot_id..'Klam:Hzor'..msg.chat_id_,name)
name = string.gsub(name,'الجرس','شيئ اذا لمسته صرخ ما هوه ؟')
name = string.gsub(name,'عقرب الساعه','اخوان لا يستطيعان تمضيه اكثر من دقيقه معا فما هما ؟')
name = string.gsub(name,'السمك','ما هو الحيوان الذي لم يصعد الى سفينة نوح عليه السلام ؟')
name = string.gsub(name,'المطر','شيئ يسقط على رأسك من الاعلى ولا يجرحك فما هو ؟')
name = string.gsub(name,'5','ما العدد الذي اذا ضربته بنفسه واضفت عليه 5 يصبح ثلاثين ')
name = string.gsub(name,'الكتاب','ما الشيئ الذي له اوراق وليس له جذور ؟')
name = string.gsub(name,'البسمار','ما هو الشيئ الذي لا يمشي الا بالضرب ؟')
name = string.gsub(name,'7','عائله مؤلفه من 6 بنات واخ لكل منهن .فكم عدد افراد العائله ')
name = string.gsub(name,'الكعبه','ما هو الشيئ الموجود وسط مكة ؟')
name = string.gsub(name,'بيت الشعر','ما هو البيت الذي ليس فيه ابواب ولا نوافذ ؟ ')
name = string.gsub(name,'لهانه','وحده حلوه ومغروره تلبس مية تنوره .من هيه ؟ ')
name = string.gsub(name,'انا','ابن امك وابن ابيك وليس باختك ولا باخيك فمن يكون ؟')
name = string.gsub(name,'امي','اخت خالك وليست خالتك من تكون ؟ ')
name = string.gsub(name,'الابره','ما هو الشيئ الذي كلما خطا خطوه فقد شيئا من ذيله ؟ ')
name = string.gsub(name,'الساعه','ما هو الشيئ الذي يقول الصدق ولكنه اذا جاع كذب ؟')
name = string.gsub(name,'22','كم مره ينطبق عقربا الساعه على بعضهما في اليوم الواحد ')
name = string.gsub(name,'غلط','ما هي الكلمه الوحيده التي تلفض غلط دائما ؟ ')
name = string.gsub(name,'كم الساعه','ما هو السؤال الذي تختلف اجابته دائما ؟')
name = string.gsub(name,'البيتنجان','جسم اسود وقلب ابيض وراس اخظر فما هو ؟')
name = string.gsub(name,'البيض','ماهو الشيئ الذي اسمه على لونه ؟')
name = string.gsub(name,'المرايه','ارى كل شيئ من دون عيون من اكون ؟ ')
name = string.gsub(name,'الضوء','ما هو الشيئ الذي يخترق الزجاج ولا يكسره ؟')
name = string.gsub(name,'الهواء','ما هو الشيئ الذي يسير امامك ولا تراه ؟')
name = string.gsub(name,'الضل','ما هو الشيئ الذي يلاحقك اينما تذهب ؟ ')
name = string.gsub(name,'العمر','ما هو الشيء الذي كلما طال قصر ؟ ')
name = string.gsub(name,'القلم','ما هو الشيئ الذي يكتب ولا يقرأ ؟')
name = string.gsub(name,'المشط','له أسنان ولا يعض ما هو ؟ ')
name = string.gsub(name,'الحفره','ما هو الشيئ اذا أخذنا منه ازداد وكبر ؟')
name = string.gsub(name,'البحر','ما هو الشيئ الذي يرفع اثقال ولا يقدر يرفع مسمار ؟')
name = string.gsub(name,'الثلج','انا ابن الماء فان تركوني في الماء مت فمن انا ؟')
name = string.gsub(name,'الاسفنج','كلي ثقوب ومع ذالك احفض الماء فمن اكون ؟')
name = string.gsub(name,'الصوت','اسير بلا رجلين ولا ادخل الا بالاذنين فمن انا ؟')
name = string.gsub(name,'بلم','حامل ومحمول نصف ناشف ونصف مبلول فمن اكون ؟ ')
send(msg.chat_id_, msg.id_,'🎊| اسرع واحد يحل الحزوره ↓\n {'..name..'}')
return false
end
end
------------------------------------------------------------------------
if text == ''..(database:get(bot_id..'Klam:Hzor'..msg.chat_id_) or '')..'' and not database:get(bot_id..'Set:Hzora'..msg.chat_id_) then
if not database:get(bot_id..'Set:Hzora'..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'🎗️| الف مبروك لقد فزت \n🎁| للعب مره اخره ارسل -›{ حزوره }')
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
database:set(bot_id..'Set:Hzora'..msg.chat_id_,true)
end 

if text == 'المعاني' or text == 'معاني' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا \n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Games'..msg.chat_id_) then
database:del(bot_id..'Set:Maany'..msg.chat_id_)
Maany_Rand = {'قرد','دجاجه','بطريق','ضفدع','بومه','نحله','ديك','جمل','بقره','دولفين','تمساح','قرش','نمر','اخطبوط','سمكه','خفاش','اسد','فأر','ذئب','فراشه','عقرب','زرافه','قنفذ','تفاحه','باذنجان'}
name = Maany_Rand[math.random(#Maany_Rand)]
database:set(bot_id..'Maany'..msg.chat_id_,name)
name = string.gsub(name,'قرد','🐒')
name = string.gsub(name,'دجاجه','🐔')
name = string.gsub(name,'بطريق','🐧')
name = string.gsub(name,'ضفدع','🐸')
name = string.gsub(name,'بومه','🦉')
name = string.gsub(name,'نحله','🐝')
name = string.gsub(name,'ديك','🐓')
name = string.gsub(name,'جمل','🐫')
name = string.gsub(name,'بقره','🐄')
name = string.gsub(name,'دولفين','??')
name = string.gsub(name,'تمساح','🐊')
name = string.gsub(name,'قرش','🦈')
name = string.gsub(name,'نمر','🐅')
name = string.gsub(name,'اخطبوط','🐙')
name = string.gsub(name,'سمكه','🐟')
name = string.gsub(name,'خفاش','🦇')
name = string.gsub(name,'اسد','🦁')
name = string.gsub(name,'فأر','🐭')
name = string.gsub(name,'ذئب','??')
name = string.gsub(name,'فراشه','🦋')
name = string.gsub(name,'عقرب','🦂')
name = string.gsub(name,'زرافه','🦒')
name = string.gsub(name,'قنفذ','🦔')
name = string.gsub(name,'تفاحه','🍎')
name = string.gsub(name,'باذنجان','🍆')
send(msg.chat_id_, msg.id_,'🎊| اسرع واحد يدز معنى السمايل -› {'..name..'}')
return false
end
end
------------------------------------------------------------------------
if text == ''..(database:get(bot_id..'Maany'..msg.chat_id_) or '')..'' and not database:get(bot_id..'Set:Maany'..msg.chat_id_) then
if not database:get(bot_id..'Set:Maany'..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'🎗️| الف مبروك لقد فزت \n🎁| للعب مره اخره ارسل -›{ معاني }')
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
database:set(bot_id..'Set:Maany'..msg.chat_id_,true)
end 
if text == 'العكس' or text == 'عكس' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا \n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Games'..msg.chat_id_) then
database:del(bot_id..'Set:Aks'..msg.chat_id_)
katu = {'باي','فهمت','موزين','اسمعك','احبك','موحلو','نضيف','حاره','ناصي','جوه','سريع','ونسه','طويل','سمين','ضعيف','شريف','شجاع','رحت','عدل','نشيط','شبعان','موعطشان','خوش ولد','اني','هادئ'}
name = katu[math.random(#katu)]
database:set(bot_id..'Set:Aks:Game'..msg.chat_id_,name)
name = string.gsub(name,'باي','هلو')
name = string.gsub(name,'فهمت','مافهمت')
name = string.gsub(name,'موزين','زين')
name = string.gsub(name,'اسمعك','ماسمعك')
name = string.gsub(name,'احبك','ماحبك')
name = string.gsub(name,'موحلو','حلو')
name = string.gsub(name,'نضيف','وصخ')
name = string.gsub(name,'حاره','بارده')
name = string.gsub(name,'ناصي','عالي')
name = string.gsub(name,'جوه','فوك')
name = string.gsub(name,'سريع','بطيء')
name = string.gsub(name,'ونسه','ضوجه')
name = string.gsub(name,'طويل','قزم')
name = string.gsub(name,'سمين','ضعيف')
name = string.gsub(name,'ضعيف','قوي')
name = string.gsub(name,'شريف','كواد')
name = string.gsub(name,'شجاع','جبان')
name = string.gsub(name,'رحت','اجيت')
name = string.gsub(name,'عدل','ميت')
name = string.gsub(name,'نشيط','كسول')
name = string.gsub(name,'شبعان','جوعان')
name = string.gsub(name,'موعطشان','عطشان')
name = string.gsub(name,'خوش ولد','موخوش ولد')
name = string.gsub(name,'اني','مطي')
name = string.gsub(name,'هادئ','عصبي')
send(msg.chat_id_, msg.id_,'🎊| اسرع واحد يدز العكس -› {'..name..'}')
return false
end
end
------------------------------------------------------------------------
if text == ''..(database:get(bot_id..'Set:Aks:Game'..msg.chat_id_) or '')..'' and not database:get(bot_id..'Set:Aks'..msg.chat_id_) then
if not database:get(bot_id..'Set:Aks'..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'🎗️| الف مبروك لقد فزت \n🎁| للعب مره اخره ارسل -›{ العكس }')
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
database:set(bot_id..'Set:Aks'..msg.chat_id_,true)
end 

if database:get(bot_id.."GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then  
if text and text:match("^(%d+)$") then
local NUM = text:match("^(%d+)$")
if tonumber(NUM) > 20 then
send(msg.chat_id_, msg.id_,"⚠️| عذرآ لا يمكنك تخمين عدد اكبر من ال { 20 } خمن رقم ما بين ال{ 1 و 20 }\n")
return false  end 
local GETNUM = database:get(bot_id.."GAMES:NUM"..msg.chat_id_)
if tonumber(NUM) == tonumber(GETNUM) then
database:del(bot_id..'SADD:NUM'..msg.chat_id_..msg.sender_user_id_)
database:del(bot_id.."GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_,5)  
send(msg.chat_id_, msg.id_,'🎁| مبروك فزت ويانه وخمنت الرقم الصحيح\n🔢| تم اضافة { 5 } من النقاط \n')
elseif tonumber(NUM) ~= tonumber(GETNUM) then
database:incrby(bot_id..'SADD:NUM'..msg.chat_id_..msg.sender_user_id_,1)
if tonumber(database:get(bot_id..'SADD:NUM'..msg.chat_id_..msg.sender_user_id_)) >= 3 then
database:del(bot_id..'SADD:NUM'..msg.chat_id_..msg.sender_user_id_)
database:del(bot_id.."GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
send(msg.chat_id_, msg.id_,'🚸| اوبس لقد خسرت في اللعبه \n🎭| حظآ اوفر في المره القادمه \n▶️| كان الرقم الذي تم تخمينه { '..GETNUM..' }')
else
send(msg.chat_id_, msg.id_,'🚸| اوبس تخمينك غلط \n↪️| ارسل رقم تخمنه مره اخرى ')
end
end
end
end
if text == 'خمن' or text == 'التخمين' then   
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا \n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Games'..msg.chat_id_) then
Num = math.random(1,20)
database:set(bot_id.."GAMES:NUM"..msg.chat_id_,Num) 
send(msg.chat_id_, msg.id_,'\n👋🏻| اهلا بك عزيزي في لعبة التخمين :\n ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯\n'..'▶️| ملاحظه لديك { 3 } محاولات فقط فكر قبل ارسال تخمينك \n\n'..'🎭| سيتم تخمين عدد ما بين ال {1 و 20} اذا تعتقد انك تستطيع الفوز جرب واللعب الان ؟ ')
database:setex(bot_id.."GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 100, true)  
return false  
end
end

if database:get(bot_id.."SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then  
if text and text:match("^(%d+)$") then
local NUM = text:match("^(%d+)$")
if tonumber(NUM) > 6 then
send(msg.chat_id_, msg.id_,"↪️| عذرا لا يوجد سواء { 6 } اختيارات فقط ارسل اختيارك مره اخرى\n")
return false  end 
local GETNUM = database:get(bot_id.."Games:Bat"..msg.chat_id_)
if tonumber(NUM) == tonumber(GETNUM) then
database:del(bot_id.."SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
send(msg.chat_id_, msg.id_,'🎗️| مبروك فزت وطلعت المحيبس بل ايد رقم { '..NUM..' }\n🎁| لقد حصلت على { 3 }من نقاط يمكنك استبدالهن برسائل ')
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_,3)  
elseif tonumber(NUM) ~= tonumber(GETNUM) then
database:del(bot_id.."SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
send(msg.chat_id_, msg.id_,'🎭| للاسف لقد خسرت \n👊| المحيبس بل ايد رقم { '..GETNUM..' }\n◀️| حاول مره اخرى للعثور على المحيبس')
end
end
end

if text == 'محيبس' or text == 'بات' or text == 'البات' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Games'..msg.chat_id_) then   
Num = math.random(1,6)
database:set(bot_id.."Games:Bat"..msg.chat_id_,Num) 
TEST = [[
*➀      ➁       ➂       ➃       ➄       ➅
  ↓        ↓        ↓         ↓        ↓         ↓   
👊 ‹•› 👊🏻 ‹•› 👊🏼 ‹•› 👊🏽 ‹•› 👊🏾 ‹•› 👊🏿


◀️| اختر لأستخراج المحيبس الايد التي تحمل المحيبس 
🎁| الفائز يحصل على { 3 } من النقاط *
]]
send(msg.chat_id_, msg.id_,TEST)
database:setex(bot_id.."SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 100, true)  
return false  
end
end

------------------------------------------------------------------------
if text == 'المختلف' or text == 'مختلف' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Games'..msg.chat_id_) then
mktlf = {'😸','☠','🐼','🐇','??','🌚','⭐️','✨','⛈','🌥','⛄️','👨‍🔬','👨‍💻','👨‍🔧','👩‍🍳','🧚‍♀','??‍♂','??‍♂','🙍‍♂','🧖‍♂','👬','👨‍👨‍👧','🕒','🕤','⌛️','📅',};
name = mktlf[math.random(#mktlf)]
database:del(bot_id..'Set:Moktlf:Bot'..msg.chat_id_)
database:set(bot_id..':Set:Moktlf'..msg.chat_id_,name)
name = string.gsub(name,'😸','😹😹😹😹😹😹😹😹😸😹😹😹😹')
name = string.gsub(name,'☠','💀💀💀💀💀💀💀☠💀💀💀💀💀')
name = string.gsub(name,'🐼','👻👻👻🐼👻👻👻👻👻👻👻')
name = string.gsub(name,'🐇','🕊🕊🕊🕊🕊🐇🕊🕊🕊🕊')
name = string.gsub(name,'🌑','🌚🌚🌚🌚🌚🌑🌚🌚🌚')
name = string.gsub(name,'🌚','🌑🌑🌑🌑🌑🌚🌑🌑🌑')
name = string.gsub(name,'⭐️','🌟🌟🌟🌟🌟🌟🌟🌟⭐️🌟🌟🌟')
name = string.gsub(name,'✨','💫💫💫💫💫✨💫💫💫💫')
name = string.gsub(name,'⛈','🌨🌨🌨🌨🌨⛈🌨🌨🌨🌨')
name = string.gsub(name,'🌥','⛅️⛅️⛅️⛅️⛅️⛅️🌥⛅️⛅️⛅️⛅️')
name = string.gsub(name,'⛄️','☃☃☃☃☃☃⛄️☃☃☃☃')
name = string.gsub(name,'👨‍🔬','👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👨‍🔬👩‍🔬👩‍🔬👩‍🔬')
name = string.gsub(name,'👨‍💻','👩‍💻👩‍💻👩‍‍💻👩‍‍💻👩‍💻👨‍💻👩‍💻👩‍💻👩‍💻')
name = string.gsub(name,'👨‍??','👩‍🔧👩‍🔧👩‍🔧👩‍🔧👩‍🔧??‍🔧👨‍🔧👩‍🔧')
name = string.gsub(name,'👩‍🍳','👨‍🍳👨‍🍳👨‍🍳👨‍🍳👨‍🍳👩‍🍳👨‍🍳👨‍🍳👨‍🍳')
name = string.gsub(name,'🧚‍♀','🧚‍♂🧚‍♂🧚‍♂🧚‍♂🧚‍♀🧚‍♂🧚‍♂')
name = string.gsub(name,'🧜‍♂','🧜‍♀🧜‍♀🧜‍♀🧜‍♀🧜‍♀🧚‍♂🧜‍♀🧜‍♀🧜‍♀')
name = string.gsub(name,'🧝‍♂','🧝‍♀🧝‍♀🧝‍♀🧝‍♀🧝‍♀🧝‍♂🧝‍♀🧝‍♀🧝‍♀')
name = string.gsub(name,'🙍‍♂️','🙎‍♂️🙎‍♂️🙎‍♂️🙎‍♂️🙎‍♂️🙍‍♂️🙎‍♂️🙎‍♂️🙎‍♂️')
name = string.gsub(name,'🧖‍♂️','🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♂️🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♀️')
name = string.gsub(name,'👬','👭👭👭👭👭👬👭👭👭')
name = string.gsub(name,'👨‍👨‍👧','👨‍👨‍👦👨‍👨‍👦👨‍👨‍👦👨‍👨‍👦👨‍👨‍👧👨‍👨‍👦👨‍👨‍👦')
name = string.gsub(name,'🕒','🕒🕒🕒🕒🕒🕒🕓🕒🕒🕒')
name = string.gsub(name,'🕤','🕥🕥🕥🕥🕥🕤🕥🕥🕥')
name = string.gsub(name,'⌛️','⏳⏳⏳⏳⏳⏳⌛️⏳⏳')
name = string.gsub(name,'📅','📆📆📆📆📆📆📅📆📆')
send(msg.chat_id_, msg.id_,'🎊| اسرع واحد يدز الاختلاف -› {'..name..'}')
return false
end
end
------------------------------------------------------------------------
if text == ''..(database:get(bot_id..':Set:Moktlf'..msg.chat_id_) or '')..'' then 
if not database:get(bot_id..'Set:Moktlf:Bot'..msg.chat_id_) then 
database:del(bot_id..':Set:Moktlf'..msg.chat_id_)
send(msg.chat_id_, msg.id_,'🎗️| الف مبروك لقد فزت \n🎁| للعب مره اخره ارسل -›{ المختلف }')
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
database:set(bot_id..'Set:Moktlf:Bot'..msg.chat_id_,true)
end
------------------------------------------------------------------------
if text == 'الرياضيات' or text == 'رياضيات' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Games'..msg.chat_id_) then
Amer = {'22','30','33','60','90','2','5','36','16','88','50','10','19',};
name = Amer[math.random(#Amer)]
database:del(bot_id..'Set:Ryadeat:Bot'..msg.chat_id_)
database:set(bot_id..':Set:Ryadeat'..msg.chat_id_,name)
name = string.gsub(name,'22','2+20=')
name = string.gsub(name,'30','10×3=')
name = string.gsub(name,'33','30+3=')
name = string.gsub(name,'60','33+27=')
name = string.gsub(name,'90','9×9+9=')
name = string.gsub(name,'2','2×1=')
name = string.gsub(name,'5','5×1=')
name = string.gsub(name,'36','6×6=')
name = string.gsub(name,'16','2×8=')
name = string.gsub(name,'88','8+80=')
name = string.gsub(name,'50','30+20=')
name = string.gsub(name,'10','2+8=')
name = string.gsub(name,'19','6+13=')
send(msg.chat_id_, msg.id_,'🎊| حل المسأله الرياضيه  -› {'..name..'}')
return false
end
end
------------------------------------------------------------------------
if text == ''..(database:get(bot_id..':Set:Ryadeat'..msg.chat_id_) or '')..'' then 
if not database:get(bot_id..'Set:Ryadeat:Bot'..msg.chat_id_) then 
database:del(bot_id..':Set:Ryadeat'..msg.chat_id_)
send(msg.chat_id_, msg.id_,'🎗️| الف مبروك لقد فزت \n🎁| للعب مره اخره ارسل -›{ رياضيات }')
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
database:set(bot_id..'Set:Ryadeat:Bot'..msg.chat_id_,true)
end
------------------------------------------------------------------------
if text == 'انكليزي' or text == 'الانكليزي' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Games'..msg.chat_id_) then
Amer = {'معلومات','قنوات','مجموعات','كتاب','تفاحه','مختلف','سدني','فلوس','اعلم','ذئب','تمساح','ذكي',};
name = Amer[math.random(#Amer)]
database:del(bot_id..'Set:English:Bot'..msg.chat_id_)
database:set(bot_id..':Set:English'..msg.chat_id_,name)
name = string.gsub(name,'ذئب','Wolf')
name = string.gsub(name,'معلومات','Information')
name = string.gsub(name,'قنوات','Channels')
name = string.gsub(name,'مجموعات','Groups')
name = string.gsub(name,'كتاب','Book')
name = string.gsub(name,'تفاحه','Apple')
name = string.gsub(name,'سدني','Sydney')
name = string.gsub(name,'فلوس','money')
name = string.gsub(name,'اعلم','I know')
name = string.gsub(name,'تمساح','crocodile')
name = string.gsub(name,'مختلف','Different')
name = string.gsub(name,'ذكي','Intelligent')
send(msg.chat_id_, msg.id_,'🎊| ترجم الكلمات الاتيه  -› {'..name..'}')
return false
end
end
------------------------------------------------------------------------
if text == ''..(database:get(bot_id..':Set:English'..msg.chat_id_) or '')..'' then 
if not database:get(bot_id..'Set:English:Bot'..msg.chat_id_) then 
database:del(bot_id..':Set:English'..msg.chat_id_)
send(msg.chat_id_, msg.id_,'🎗️| الف مبروك لقد فزت \n🎁| للعب مره اخره ارسل -›{ `انكليزي` }')
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
database:set(bot_id..'Set:English:Bot'..msg.chat_id_,true)
end
------------------------------------------------------------------------
if text == 'امثله' or text == 'الامثله' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا\n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Games'..msg.chat_id_) then
mthal = {'جوز','ضراطه','الحبل','الحافي','شقره','بيدك','سلايه','النخله','الخيل','حداد','المبلل','يركص','قرد','العنب','العمه','الخبز','بالحصاد','شهر','شكه','يكحله',};
name = mthal[math.random(#mthal)]
database:set(bot_id..'Set:Amth'..msg.chat_id_,name)
database:del(bot_id..'Set:Amth:Bot'..msg.chat_id_)
name = string.gsub(name,'جوز','ينطي____للماعده سنون')
name = string.gsub(name,'ضراطه','الي يسوق المطي يتحمل___')
name = string.gsub(name,'بيدك','اكل___محد يفيدك')
name = string.gsub(name,'الحافي','تجدي من___نعال')
name = string.gsub(name,'شقره','مع الخيل يا___')
name = string.gsub(name,'النخله','الطول طول___والعقل عقل الصخلة')
name = string.gsub(name,'سلايه','بالوجه امراية وبالظهر___')
name = string.gsub(name,'الخيل','من قلة___شدو على الچلاب سروج')
name = string.gsub(name,'حداد','موكل من صخم وجهه كال آني___')
name = string.gsub(name,'المبلل','___ما يخاف من المطر')
name = string.gsub(name,'الحبل','اللي تلدغة الحية يخاف من جرة___')
name = string.gsub(name,'يركص','المايعرف___يكول الكاع عوجه')
name = string.gsub(name,'العنب','المايلوح___يكول حامض')
name = string.gsub(name,'العمه','___إذا حبت الچنة ابليس يدخل الجنة')
name = string.gsub(name,'الخبز','انطي___للخباز حتى لو ياكل نصه')
name = string.gsub(name,'باحصاد','اسمة___ومنجله مكسور')
name = string.gsub(name,'شهر','امشي__ولا تعبر نهر')
name = string.gsub(name,'شكه','يامن تعب يامن__يا من على الحاضر لكة')
name = string.gsub(name,'القرد','__بعين امه غزال')
name = string.gsub(name,'يكحله','اجه___عماها')
send(msg.chat_id_, msg.id_,'🎊| اسرع واحد يكمل المثل -› {'..name..'}')
return false
end
end
------------------------------------------------------------------------
if text == ''..(database:get(bot_id..'Set:Amth'..msg.chat_id_) or '')..'' then 
if not database:get(bot_id..'Set:Amth:Bot'..msg.chat_id_) then 
database:del(bot_id..'Set:Amth'..msg.chat_id_)
send(msg.chat_id_, msg.id_,'🎗️| الف مبروك لقد فزت \n🎁| للعب مره اخره ارسل -›{ امثله }')
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
database:set(bot_id..'Set:Amth:Bot'..msg.chat_id_,true)
end
------------------------------------------------------------------------
if text == "كت تويت"  then
local url,res = https.request('https://anashtick.ml/TuBak.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.TuBak ~= true then
local inline = {{{text="اضغط هنا للشتراك 🚹",url="https://t.me/TuBakx"}}}
SendInline(msg.chat_id_,'عذراً عليك الاشتراك في [. Team TuBak](t.me/TuBaKx) \nليمكنك استخدام البوت بشكل كامل',nil,inline)
return false 
end
if database:get(bot_id..'Lock:Games'..msg.chat_id_) then
local tweet = {  "آخر مرة زرت مدينة الملاهي؟",  "آخر مرة أكلت أكلتك المفضّلة؟",  "الوضع الحالي؟\n‏1. سهران\n‏2. ضايج\n‏3. أتأمل",  "آخر شيء ضاع منك؟","كلمة أخيرة لشاغل البال؟","طريقتك المعتادة في التخلّص من الطاقة السلبية؟","شهر من أشهر العام له ذكرى جميلة معك؟","كلمة غريبة من لهجتك ومعناها؟🤓","‏- شيء سمعته عالق في ذهنك هاليومين؟","متى تكره الشخص الذي أمامك حتى لو كنت مِن أشد معجبينه؟","‏- أبرز صفة حسنة في صديقك المقرب؟","هل تشعر أن هنالك مَن يُحبك؟","اذا اكتشفت أن أعز أصدقائك يضمر لك السوء، موقفك الصريح؟","أجمل شيء حصل معك خلال هاليوم؟","صِف شعورك وأنت تُحب شخص يُحب غيرك؟👀💔","كلمة لشخص غالي اشتقت إليه؟💕","آخر خبر سعيد، متى وصلك؟","أنا آسف على ....؟","أوصف نفسك بكلمة؟","صريح، مشتاق؟","‏- صريح، هل سبق وخذلت أحدهم ولو عن غير قصد؟","‏- ماذا ستختار من الكلمات لتعبر لنا عن حياتك التي عشتها الى الآن؟💭","‏- فنان/ة تود لو يدعوكَ على مائدة عشاء؟😁❤","‏- تخيّل شيء قد يحدث في المستقبل؟","‏- للشباب | آخر مرة وصلك غزل من فتاة؟🌚","شخص أو صاحب عوضك ونساك مُر الحياة ما اسمه ؟","| اذا شفت حد واعجبك وعندك الجرأه انك تروح وتتعرف عليه ، مقدمة الحديث شو راح تكون ؟."}  
send(msg.chat_id_, msg.id_, ''..tweet[math.random(#tweet)]..'')
end
end
------------------------------------------------------------------------
if text == 'تفعيل الالعاب' and Manager(msg) then   
if not database:get(bot_id..'Lock:Games'..msg.chat_id_)  then
database:set(bot_id..'Lock:Games'..msg.chat_id_,true) 
local Text = '✅| تم تفعيل الالعاب'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'✅| بالتأكيد تم تفعيل الالعاب')  
end
end
if text == 'تعطيل الالعاب' and Manager(msg) then  
if database:get(bot_id..'Lock:Games'..msg.chat_id_)  then
database:del(bot_id..'Lock:Games'..msg.chat_id_) 
local Text = '❎| تم تعطيل الالعاب'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '⏺️| معرفة المزيد ؟',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,'❎| بالتأكيد تم تعطيل الالعاب')  
end
end
if text == 'الالعاب' and database:get(bot_id..'Lock:Games'..msg.chat_id_) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🚹| يرجى الاشتراك بالقناه اولا \n▶️| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
Text_Games = [[
📋| *قائمة الالعاب الموجوده ↓↑*
 ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
 • تفعيل الالعاب / لتفعيل العبه 
 • تعطيل الالعاب / لتعطيل العبه 
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
 • لعبه البات -› لعبة المحيبس 
 • لعبه التخمين -› لعبة البحث
 • لعبه الاسرع -› لعبة اسرع شخص
 • لعبه السمايلات -› لعبة المطابقه 
 • لعبه المختلف -› لعبة الذكاء
 • لعبه الرياضيات -› لعبة الارقام
 • لعبه الانكليزي -› لعبة ترجمه
 • لعبه الامثله -› لعبة تصحيح 
 • لعبه العكس -› لعبة عكس الكلمات
 • لعبه الحزوره -› لعبة التفكير 
 • لعبه المعاني -› العبه الشهيره 
 • لعبه التويت -› كت تويت
ٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯
🚹| [Source Tubak . ](t.me/Tubakx)
]]
send(msg.chat_id_, msg.id_,Text_Games) 
end
------------------------------------------------------------------------
if text == "غنيلي" then
data,res = https.request('https://black-source.tk/BlackTeAM/audios.php')
if res == 200 then
audios = json:decode(data)
if audios.Info == true then
local Text ='🔊| تم اختيار المقطع الصوتي لك'
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '⏺️| معرفة المزيد؟ ',url="t.me/TUBAKX"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendVoice?chat_id=' .. msg.chat_id_ .. '&voice='..URL.escape(audios.info)..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
end
-------------------------------
if text == "السلام عليكم" or text == "سلام عليكم" or text == "سلامن عليكم" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"وعليكم السلام حبيبي🌚","وعليكم السلام 🌝" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "شلونك" or text == "شلونكم" or text == "شونك" or text == "شلونج" or text == "شونج" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"تمـام يقلبي ونتا 💘🌚","معليك بينه حبيبي 👋🏻🌝","زينين نت شلونك 😶" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "بوسني" or text == "بوسيني" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"عـيب أبني تـوكل 🌝😹","ليش مـا تبوسنـي 🙁😹" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "🌝" or text == "😐" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"ههـݪـﯡٰ 🌝💕","يا ڪمࢪ ☹️💗"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "🙊" or text == "🙈" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"فدوا اروحلك لصير كانسر 🤣","لك ها قرد 🙁😹"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "هلو" or text == "هلاو" or text == "هلا" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"ﮪـلاواتــہ 🥳💗","ههلو ، 🥳😹💞","ﮪـلـﯠآت ؏ـمريہٰ ☹️💗." }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "صباحوا" or text == "صباح الخير" or text == "صباحو" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"صبـﺎُحح ﺎُݪعسل 🥳💞.","صبـﺎُحح ﺎُݪـعافية 😗🍇.","صبـﺎُحح ﺎُݪـخَـير 🍒🤍." }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "هاي" or text == "ههاي" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"هايات ؏ـمريہٰ ☹️💗","ﮪـايات حبيـبيہٰ 😗💗." }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "شكو" or text == "شكوو" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"صارت دمايه بين المشرفين 😂🙁","ماكو شي ارجع نام 🌝💕" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "باي" or text == "رايح" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"هـا وين 💞🌝","ويـن حبـيبي 🙁؟" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "جاو" or text == "ججاو" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"هـا ضلـعي وين؟  💔","بسلامة 💕" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "نورت" or text == "منور" or text == "منوره" or text == "نورتي" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"نـورك قـلبي . 💘🙁","ئمنورني يوردة ماشرب اني 💘🌝😹" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "اريد ارتبط" or text ==  "اريد اكبل"then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"شـﯡٰفلڪ حاتهہ منـہ. المشرفات 😂💔" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "منو حذف" or text == "منو حذف رسائلي" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"شوف ﺎُݪاحداث 🌝😂" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "تف" or text == "تفف" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"بحلكك حبي 🌚","عليك وع المنشئ 😹🌚" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "😂" or text == "😂😂" or text == "😂😂😂😂" or text == "😂😂😂" or text == "😹😹" or text == "😹😹😹" or text == "😹" or text == "😹😹😹😹" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"دايـما حب 💘🌝","مو ضحكةة ضيم 🌚😹","لصير كانسر وتضحك هواي وردة 🌚😂" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "😒" or text == "😒😒" or text == "😒😒😒" or text == "😒😒😒😒" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"عـوع شهل خلقةة 🙁😂","ئمـور وردة 🌝😹","لـضوج وجه الجـوب ☹️😂" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "اسم البوت" or text == "البوت" or text == "هاذ بوت" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"ﮪـاحبيـبيہٰ 🌝💗.","اسمي كدامك لصير كانسر لفل ماكس وديربالك تخمط ترا الكفك 😹🌚💘" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "تحبني" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"أسـف مـادور 😘😂","امـوت ع ريـحت ابـاطك 🌚😹" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "جوعان" or text == "جوعانه" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"تريد اسويلك بيتزا مثلاََ😒😒","اي روح اكل انيشعلي","تعال اكلني 😐😂" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "ههه" or text == "هههه" or text == "ههههه" or text == "هههههه" or text == "ههههههه" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"دومـم حبيـبيہٰ 😗💗.","لصير كانسر وتضحك هواي 😹🌚" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "اكلك" or text == "اكلج" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"كـول ولتعبـني 💘🌚","فضـها شتريد ؟ 🙁" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "@VlVlVI" or text == "@vlvlvi" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"مطوري القميل 💕","مطور السورس هاذ حبي 🙁","تحياتي المطوري منورني يوردة ماشرب اني 🌚😹" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "شبيك" or text == "شبيج" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"مـابية وداعت كاظم الساهـر 🤣","بيه نت 😔😂💘" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "فديتك" or text == "فديتج" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"فـداك المنشئ حبيبي 🌚😹" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "ميتين" or text == "وينكم" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"طامسين عمي كلواحد نايم بحظن حبيبته 🌚","عوفهم حبي هذول نايمين بل خاص كلمن عد حبيبته","كول شتريد" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "احبك" or text == "حبك" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"واني هم حبيبي 💘","دعبل مادور 🌚😹","شوفلك حاته اني شنو 🙁😹" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "مساء الخير" or text == "مساء لخير" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"م ـساء ﺎُݪوࢪد 🥳💞" }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == "انجب" or text == "نجب" or text == "أنجب" or text == "نجبب" or text == "جب" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"ليش متنجب انته لا تندفر 🌚😹","صار حبيبي 💘","اخلاقك لا تنشحت " }
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
------------------------------------------------------------------------
if (text and text == "تعطيل اوامر التحشيش") then 
send(msg.chat_id_, msg.id_, '❎| تم تعطيل اوامر التحشيش')
database:set(bot_id.."Fun_Bots:"..msg.chat_id_,"true")
end
if (text and text == "تفعيل اوامر التحشيش") then 
send(msg.chat_id_, msg.id_, '✅| تم تفعيل اوامر التحشيش')
database:del(bot_id.."Fun_Bots:"..msg.chat_id_)
end
local Name_Bot = (database:get(bot_id..'Name:Bot') or 'توباك')
if not database:get(bot_id.."Fun_Bots:"..msg.chat_id_) then
if text ==  ""..Name_Bot..' شنو رئيك بهاذا' and tonumber(msg.reply_to_message_id_) > 0 then     
function FunBot(extra, result, success) 
local Fun = {'لوكي وزاحف من ساع زحفلي وحضرته 😒','خوش ولد و ورده مال الله 💋🙄','يلعب ع البنات 🙄', 'ولد زايعته الكاع 😶🙊','صاك يخبل ومعضل ','محلو وشواربه جنها مكناسه 😂🤷🏼‍♀️','اموت عليه 🌝','هوه غير ا��حب مال اني 🤓❤️','مو خوش ولد صراحه ☹️','ادبسز وميحترم البنات  ', 'فد واحد قذر 🙄😒','ماطيقه كل ما اكمشه ريحته جنها بخاخ بف باف مال حشرات 😂🤷‍♀️','مو خوش ولد 🤓' } 
send(msg.chat_id_, result.id_,''..Fun[math.random(#Fun)]..'')   
end   
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunBot, nil)
return false
end  
if text == ""..Name_Bot..'تحب هذا' and tonumber(msg.reply_to_message_id_) > 0 then    
function FunBot(extra, result, success) 
local Fun = {'الكبد مال اني ','يولي ماحبه ',' لٱ ايع ','بس لو الكفها اله اعضها 💔','ماخب مطايه اسف','اكلك ۿذﭑ يكلي احبكك لولا ﭑݩٺ شتكول  ','ئووووووووف اموت ع ربه ','ايععععععععع','بلعباس اعشكك','ماحب مخابيل','احبب ميدو وبس','لٱ ماحبه','بله هاي جهره تكلي تحبهه ؟ ','بربك ئنته والله فارغ وبطران وماعدك شي تسوي جاي تسئلني احبهم لولا','افبس حبيبي هذا' } 
send(msg.chat_id_,result.id_,''..Fun[math.random(#Fun)]..'') 
end  
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunBot, nil)
return false
end    
end
if text and text:match('^'..Name_Bot..' ') then
data.message_.content_.text_ = data.message_.content_.text_:gsub('^'..Name_Bot..' ','')
end
if text and text:match('^'..Name_Bot..' ') then
data.message_.content_.text_ = data.message_.content_.text_:gsub('^'..Name_Bot..' ','')
end
if text == "نسبه الحب" or text == "نسبه حب" and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
if not database:get(bot_id..'Cick:lov'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":lov_Bots"..msg.chat_id_,"sendlove")
Text = '🚹| ارسل اسمك واسم الشخص : \n◀️| كمثال : *احمد و محمد*'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه الحب" and database:get(bot_id..":"..msg.sender_user_id_..":lov_Bots"..msg.chat_id_) == "sendlove" then
num = {"💔 10","💔😐 20","💔☹️ 30","💔🙁 35","💕😊 75","💔 34","💕😔 66","💛😍 82","☹️ 23","💔 19","💕☹️ 55","😂☹️ 8","🥰 63","😒 32","27","89","99","98","3","80","49","100","6","0",};
sendnum = num[math.random(#num)]
local Text = '🚹| اليك النتائج الخـاصة :\n\n◀️| نسبة الحب بيـن : *'..text..'*'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '-›› '..sendnum..'%',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
database:del(bot_id..":"..msg.sender_user_id_..":lov_Bots"..msg.chat_id_)
end
if text == "نسبه الكره" or text == "نسبه كره" and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
if not database:get(bot_id..'Cick:krh'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":krh_Bots"..msg.chat_id_,"sendkrhe")
Text = '🚹| ارسل اسمك واسم الشخص : \n◀️| كمثال : *احمد و محمد*'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه الكره" and database:get(bot_id..":"..msg.sender_user_id_..":krh_Bots"..msg.chat_id_) == "sendkrhe" then
num = {"10","20","30","35","75","34","66","82","23","19","55","8","63","32","27","89","99","98","3","80","8","100","6","0",};
sendnum = num[math.random(#num)]
local Text = '🚹| اليك النتائج الخـاصة :\n\n◀️| نسبه الكرة : *'..text..'*'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '-›› '..sendnum..'%',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
database:del(bot_id..":"..msg.sender_user_id_..":krh_Bots"..msg.chat_id_)
end
if text == "نسبه رجوله" or text == "نسبه الرجوله" and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
if not database:get(bot_id..'Cick:rjo'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":rjo_Bots"..msg.chat_id_,"sendrjoe")
Text = '🚹|ارسل اسم الشخص : \n◀️| كمثال : *احـمد*'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه رجوله" and database:get(bot_id..":"..msg.sender_user_id_..":rjo_Bots"..msg.chat_id_) == "sendrjoe" then
numj = {"10","20","30","35","75","34","66","82","23","19","55","80","63","32","27","89","99","98","79","100","8","3","6","0",};
sendnuj = numj[math.random(#numj)]
local Text = '🚹| اليك النتائج الخـاصة :\n\n◀️| نسبة الرجوله لـ : *'..text..'*'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '-›› '..sendnuj..'%',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
database:del(bot_id..":"..msg.sender_user_id_..":rjo_Bots"..msg.chat_id_)
end
if text == "نسبه الانوثه" or text == "نسبه انوثه" and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
if not database:get(bot_id..'Cick:ano'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":ano_Bots"..msg.chat_id_,"sendanoe")
Text = '🚹| ارسل اسم الشخص : \n◀️| كمثال : *احـمد*'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه الانوثه" and database:get(bot_id..":"..msg.sender_user_id_..":ano_Bots"..msg.chat_id_) == "sendanoe" then
numj = {"10","20","30","35","75","34","66","82","23","19","55","80","63","32","27","89","99","98","79","100","8","3","6","0",};
sendnuj = numj[math.random(#numj)]
local Text = '🚹| اليك النتائج الخـاصة :\n\n◀️| نسبه الانوثة لـ : *'..text..'*'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '-›› '..sendnuj..'%',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
database:del(bot_id..":"..msg.sender_user_id_..":ano_Bots"..msg.chat_id_)
end
if text == "كشف الحيوان" or text == "نسبه انوثه" and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
if not database:get(bot_id..'Cick:ono'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":ono_Bots"..msg.chat_id_,"sendonoe")
Text = '🚹| ارسل اسم الشخص : \n◀️| كمثال : *احـمد*'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="كشف الحيوان" and database:get(bot_id..":"..msg.sender_user_id_..":ono_Bots"..msg.chat_id_) == "sendonoe" then
numj = {"قنفذ 🦝","صخل 🐐","جلب 🦮","بقرة 🐄","خنزير 🐖","قرد 🦧","فأر 🐁","تمساح 🐊","ذبانه 🪰","حصان 🐴",};
sendnmj = numj[math.random(#numj)]
local Text = '🚹| اليك النتائج الخـاصة :\n\n◀️| نوع الحيوان لـ : *'..text..'*'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = ''..sendnmj..' ‹‹-',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
database:del(bot_id..":"..msg.sender_user_id_..":ono_Bots"..msg.chat_id_)
end
if text == "كشف الارتباط" or text == "نسبه الارتباط" and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
if not database:get(bot_id..'Cick:goo'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":goo_Bots"..msg.chat_id_,"sendonoe")
Text = '🚹| ارسل اسم الشخص : \n◀️| كمثال : *احـمد*'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="كشف الارتباط" and database:get(bot_id..":"..msg.sender_user_id_..":goo_Bots"..msg.chat_id_) == "sendonoe" then
numj = {"مرتبط 💔😐","خاين 😊😂","ممرتبط 😗","مرتبط ب 10 🙁😂","زاحف على 4 🥰😂",};
sendnuk = numj[math.random(#numj)]
local Text = '🚹| اليك النتائج الخـاصة :\n\n◀️| نوع الكشف لـ : *'..text..'*'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = ''..sendnuk..' ‹‹-',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
database:del(bot_id..":"..msg.sender_user_id_..":goo_Bots"..msg.chat_id_)
end
if text == "نسبه الغباء" or text == "نسبة الغباء" and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
if not database:get(bot_id..'Cick:vov'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":vov_Bots"..msg.chat_id_,"sendonoe")
Text = '🚹| ارسل اسم الشخص : \n◀️| كمثال : *احـمد*'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه الغباء" and database:get(bot_id..":"..msg.sender_user_id_..":vov_Bots"..msg.chat_id_) == "sendonoe" then
numj = {"😘 10","🥰 20 ","😶 30","🤔 35","😝 75","😴 34","😏 66","😕 82","😭 23","19","55","80","63","32","27","89","99 😂😔","98","79","100 😂😘","8","3 💘","6","0 👋🏻",};
sendnnk = numj[math.random(#numj)]
local Text = '🚹| اليك النتائج الخـاصة :\n\n◀️| نسبة الغباء لـ : *'..text..'*'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '-›› '..sendnnk..'%',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
database:del(bot_id..":"..msg.sender_user_id_..":vov_Bots"..msg.chat_id_)
end

if text == "نسبه الزحف" or text == "نسبة الزحف" and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
if not database:get(bot_id..'Cick:zff'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":zff_Bots"..msg.chat_id_,"sendonoe")
Text = '🚹| ارسل اسم الشخص : \n◀️| كمثال : *احـمد*'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه الزحف" and database:get(bot_id..":"..msg.sender_user_id_..":zff_Bots"..msg.chat_id_) == "sendonoe" then
numj = {"🤣 10","🥰 20 ","😶 30","🤔 35","😝 75","😴 34","😏 66","😕 82","😭 23","🌚😹 19","😹😔 55","😘😹 80","☹️😹 63","🌝😹 32","☺️😹 27","😍😂 89","😎😂 99","🤣 98","🌚😂 79","😔😹 100","💘🌚 8","😎 3","😔 6","☹️ 0",};
sendzff = numj[math.random(#numj)]
local Text = '🚹| اليك النتائج الخـاصة :\n\n◀️| نسبة الزحف لـ : *'..text..'*'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '-›› '..sendzff..'%',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
database:del(bot_id..":"..msg.sender_user_id_..":zff_Bots"..msg.chat_id_)
end
if text == "نسبه الخيانه" or text == "نسبة الخيانة" and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
if not database:get(bot_id..'Cick:hen'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":hen_Bots"..msg.chat_id_,"sendonoe")
Text = '🚹| ارسل اسم الشخص : \n◀️| كمثال : *احـمد*'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه الخيانه" and database:get(bot_id..":"..msg.sender_user_id_..":hen_Bots"..msg.chat_id_) == "sendonoe" then
numj = {"👋🏻🌚 10","🌙🥺 20 ","☹️ ↗️ 30","🌚😂 35","😔💔 75","👋🏻🥺 34","💔😶 66","💔😕 82","💔😭 23","💭🌝 19","🙄😂 55","😘😹 80","☹️😹 63","🌝😹 32","☺️😹 27","😍😂 89","😎😂 99","🤣 98","🌚😂 79","😔😹 100","💘🌚 8","😎 3","😔 6","☹️ 0",};
sendhen = numj[math.random(#numj)]
local Text = '🚹| اليك النتائج الخـاصة :\n\n◀️| نسبة الزحف لـ : *'..text..'*'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '-›› '..sendhen..'%',url="https://t.me/TuBaKx"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
database:del(bot_id..":"..msg.sender_user_id_..":hen_Bots"..msg.chat_id_)
end
--------------------------------------------------------------
if text and text:match("^كول (.*)$") then
local Textxt = text:match("^كول (.*)$")
send(msg.chat_id_, msg.id_, '['..Textxt..']')
end
if text == "راسلني" then
rpl = {"ها حب","جيت كلبي 🌝","كول حب؟ 😗💛","تفـضل 💕"};
sender = rpl[math.random(#rpl)]
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendmessage?chat_id=' .. msg.sender_user_id_ .. '&text=' .. URL.escape(sender))
end
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and Muted_User(msg.chat_id_,msg.sender_user_id_) then 
DeleteMessage(msg.chat_id_, {[0] = msg.id_})  
return false  
end
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and Ban_User(msg.chat_id_,msg.sender_user_id_) then 
chat_kick(msg.chat_id_,msg.sender_user_id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false  
end
--------------------------------------------------------------------------------------------------------------
if msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and Ban_User(msg.chat_id_,msg.content_.members_[0].id_) then 
chat_kick(msg.chat_id_,msg.content_.members_[0].id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false
end
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and GBan_User(msg.sender_user_id_) then 
chat_kick(msg.chat_id_,msg.sender_user_id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false 
end
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and Gmute_User(msg.sender_user_id_) then 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false 
end
--------------------------------------------------------------------------------------------------------------
if msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and GBan_User(msg.content_.members_[0].id_) then 
chat_kick(msg.chat_id_,msg.content_.members_[0].id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_})  
end 
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatAddMembers" then  
database:set(bot_id.."Who:Added:Me"..msg.chat_id_..':'..msg.content_.members_[0].id_,msg.sender_user_id_)
local mem_id = msg.content_.members_  
local Bots = database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) 
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and not Mod(msg) and Bots == "kick" then   
https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..msg.sender_user_id_)
TuBacK = https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local Json_Info = JSON.decode(TuBacK)
if Json_Info.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_})
tdcli_function({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah) local admins = tah.members_ for i=0 , #admins do if tah.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not is_mod(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end     
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatAddMembers" then  
local mem_id = msg.content_.members_  
local Bots = database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) 
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and not Mod(msg) and Bots == "del" then   
TuBacK = https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local Json_Info = JSON.decode(TuBacK)
if Json_Info.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_})
tdcli_function({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah) local admins = tah.members_ for i=0 , #admins do if tah.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not is_mod(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end     
end
end
if msg.content_.ID == 'MessagePinMessage' then
if Constructor(msg) then 
database:set(bot_id..'Pin:Id:Msg'..msg.chat_id_,msg.content_.message_id_)
else
local Msg_Pin = database:get(bot_id..'Pin:Id:Msg'..msg.chat_id_)
if Msg_Pin and database:get(bot_id.."lockpin"..msg.chat_id_) then
PinMessage(msg.chat_id_,Msg_Pin)
end
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatDeletePhoto" or msg.content_.ID == "MessageChatChangePhoto" or msg.content_.ID == 'MessagePinMessage' or msg.content_.ID == "MessageChatJoinByLink" or msg.content_.ID == "MessageChatAddMembers" or msg.content_.ID == 'MessageChatChangeTitle' or msg.content_.ID == "MessageChatDeleteMember" then   
if database:get(bot_id..'lock:tagservr'..msg.chat_id_) then  
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false
end    
end   
--------------------------------------------------------------------------------------------------------------
SourceTuBacK(data.message_,data)
plugin_TuBacK(data.message_)
--------------------------------------------------------------------------------------------------------------
if Chat_Type == 'GroupBot' and ChekAdd(msg.chat_id_) == true then
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ then
database:set(bot_id..'user:Name'..msg.sender_user_id_,(data.username_))
end
--------------------------------------------------------------------------------------------------------------
if tonumber(data.id_) == tonumber(bot_id) then
return false
end
end,nil)   
end
elseif (data.ID == "UpdateMessageEdited") then
local msg = data
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.message_id_)},function(extra, result, success)
database:incr(bot_id..'edits'..result.chat_id_..result.sender_user_id_)
local Text = result.content_.text_
if database:get(bot_id.."lock_edit_med"..msg.chat_id_) and not Text and not BasicConstructor(result) then
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local username = data.username_
local name = data.first_name_
local iduser = data.id_
local users = ('[@'..data.username_..']' or iduser)
local list = database:smembers(bot_id..'Constructor'..msg.chat_id_)
t = "\n🚹| شخص ما يحاول تعديل الميديا \n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "⚠️| لا يوجد ادمن"
end
send(msg.chat_id_,0,''..t..'\nٴ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯ ⎯\n🚷| تم التعديل على الميديا\n▶️| الشخص الي قام بالتعديل\n🚸| ايدي الشخص -› '..result.sender_user_id_..'\n🏷️| معرف الشخص -› { '..users..' }') 
end,nil)
DeleteMessage(msg.chat_id_,{[0] = msg.message_id_}) 
end
local text = result.content_.text_
if not Mod(result) then
------------------------------------------------------------------------
if text and text:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]") or text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text and text:match("[Tt].[Mm][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text and text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end
------------------------------------------------------------------------
if text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text and text:match("[Tt].[Mm][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text and text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end
------------------------------------------------------------------------
if text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text and text:match("[Tt].[Mm][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text and text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end
------------------------------------------------------------------------
if text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text and text:match("[Tt].[Mm][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text and text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text and text:match("[hH][tT][tT][pP][sT]") or text and text:match("[tT][eE][lL][eE][gG][rR][aA].[Pp][Hh]") or text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa].[Pp][Hh]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text and text:match("(.*)(@)(.*)") then
if database:get(bot_id.."lock:user:name"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end
------------------------------------------------------------------------
if text and text:match("@") then
if database:get(bot_id.."lock:user:name"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text and text:match("(.*)(#)(.*)") then
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text and text:match("#") then
if database:get(bot_id.."lock:user:name"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
local TuBacKAbot = database:get(bot_id.."TuBacK1:Add:Filter:Rp2"..text..result.chat_id_)   
if TuBacKAbot then    
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0,"🚹| العضو : {["..data.first_name_.."](T.ME/"..data.username_..")}\n▶️| ["..TuBacKAbot.."] \n") 
else
send(msg.chat_id_,0,"🚹| العضو : {["..data.first_name_.."](T.ME/TuBakx)}\n▶️| ["..TuBacKAbot.."] \n") 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end
------------------------------------------------------------------------
if text and text:match("/") then
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end 
if text and text:match("(.*)(/)(.*)") then
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end
------------------------------------------------------------------------
if text then
local TuBacK1_Msg = database:get(bot_id.."TuBacK1:Add:Filter:Rp2"..text..result.chat_id_)   
if TuBacK1_Msg then    
send(msg.chat_id_, msg.id_,"🚹| "..TuBacK1_Msg)
DeleteMessage(result.chat_id_, {[0] = data.message_id_})     
return false
end
end
end
end,nil)
------------------------------------------------------------------------

elseif (data.ID == "UpdateOption" and data.name_ == "my_id") then 
local list = database:smembers(bot_id.."User_Bot") 
for k,v in pairs(list) do 
tdcli_function({ID='GetChat',chat_id_ = v},function(arg,data) end,nil) 
end         
local list = database:smembers(bot_id..'Chek:Groups') 
for k,v in pairs(list) do 
tdcli_function({ID='GetChat',chat_id_ = v
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
database:srem(bot_id..'Chek:Groups',v)  
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=v,user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
database:srem(bot_id..'Chek:Groups',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
database:srem(bot_id..'Chek:Groups',v)  
end
if data and data.code_ and data.code_ == 400 then
database:srem(bot_id..'Chek:Groups',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusEditor" then
database:sadd(bot_id..'Chek:Groups',v)  
end 
end,nil)
end

elseif (data.ID == "UpdateMessageSendSucceeded") then
local msg = data.message_
local text = msg.content_.text_
local Get_Msg_Pin = database:get(bot_id..'Msg:Pin:Chat'..msg.chat_id_)
if Get_Msg_Pin ~= nil then
if text == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) if d.ID == 'Ok' then;database:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_);end;end,nil)   
elseif (msg.content_.sticker_) then 
if Get_Msg_Pin == msg.content_.sticker_.sticker_.persistent_id_ then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) database:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
if (msg.content_.animation_) then 
if msg.content_.animation_.animation_.persistent_id_ == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) database:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
if (msg.content_.photo_) then
if msg.content_.photo_.sizes_[0] then
id_photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
id_photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
id_photo = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
id_photo = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
if id_photo == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) database:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
end


end -- end new msg dev.mr ahmd 
end -- end callback dev.mr ahmd
















