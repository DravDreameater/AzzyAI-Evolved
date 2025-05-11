-----------------------------
-- Dr. Azzy's Mercenary AI
-- Written by Dr. Azzy of iRO Loki
-- Permission granted to distribute in unmodified form
-- Please contact me via the iRO Forums if you wish to modify
-- so that we can work together to extend and improve this AI.
-----------------------------

-- Define version and error-related variables
Version="1.56" 
ErrorCode=""
ErrorInfo=""
LastSavedDate=""
TactLastSavedDate=""
TypeString="M"

-- Load required files for the AI functionality
dofile( "./AI/USER_AI/Const_.lua")
dofile( "./AI/USER_AI/M_SkillList.lua" )
dofile( "./AI/USER_AI/Defaults.lua")
dofile( "./AI/USER_AI/AzzyUtil.lua")
dofile( "./AI/USER_AI/Stubs.lua")
dofile( "./AI/USER_AI/A_Friends.lua")
dofile( "./AI/USER_AI/M_Config.lua")
dofile( "./AI/USER_AI/M_Tactics.lua")

-- Load Mob_ID.lua safely using pcall to handle potential errors
pcall(function () dofile( "./AI/USER_AI/Mob_ID.lua") end)

-- Load additional AI-related files
dofile( "./AI/USER_AI/AI_main.lua")
dofile( "./AI/USER_AI/M_PVP_Tact.lua")
dofile( "./AI/USER_AI/M_Extra.lua")

-- Function to write a startup log for the AI
function WriteStartupLog(Version,ErrorCode,ErrorInfo)
	local verspattern="%d.%d%d" -- Pattern to match version numbers
	OutFile=io.open("AAIStartM.txt","w") -- Open a file to write the startup log

	-- Check the version of AzzyUtil.lua
	if AUVersion==nil then
		AUVersion="1.30b or earlier"
		ErrorCode="File version error"
		ErrorInfo=ErrorInfo.."AzzyUtil.lua no version found"
	elseif string.gfind(AUVersion,verspattern)()~="1.56" then
		ErrorCode="File version error"
		ErrorInfo=ErrorInfo.."AzzyUtil.lua wrong version "..string.gfind(AUVersion,verspattern)().."\n"
	end

	-- Test if the data folder is accessible
	TestFile=io.open("./AI/USER_AI/data/testM.txt","w")
	if TestFile~=nil then
		TestFile:close()
	else
		ErrorCode="cannot create files in data folder"
		ErrorInfo=ErrorInfo.." Data folder likely missing. Create folder named 'data' in USER_AI "
	end

	-- Check the version of Const_.lua
	if CVersion==nil then
		CVersion="1.30b or earlier"
		ErrorCode="File version error"
		ErrorInfo=ErrorInfo.."Const_.lua no version found"
	elseif string.gfind(CVersion,verspattern)()~="1.56" then
		ErrorCode="File version error"
		ErrorInfo=ErrorInfo.."Const_.lua wrong version "..string.gfind(CVersion,verspattern)().."\n"
	end

	-- Check the version of AI_main.lua
	if MainVersion==nil then
		MainVersion="1.30b or earlier"
		ErrorCode="File version error"
		ErrorInfo=ErrorInfo.." AI_main.lua no version found"
	elseif string.gfind(MainVersion,verspattern)()~="1.56" then
		ErrorCode="File version error"
		ErrorInfo=ErrorInfo.."AI_main.lua wrong version "..string.gfind(MainVersion,verspattern)().."\n"
	end

	-- Check if M_Config.lua has been modified
	if fsize("./AI/USER_AI/M_Config.lua")==3017 then
		ConfigVers="Default: "..LastSavedDate
	else
		ConfigVers="Custom, edited "..LastSavedDate
	end

	-- Check if M_Tactics.lua has been modified
	if fsize("./AI/USER_AI/M_Tactics.lua")==547 then
		TacticVers="Default: "..TactLastSavedDate
	else
		TacticVers="Custom, edited "..TactLastSavedDate
	end	

	-- Check for potential exploit usage
	if GetSkillInfo(ML_PIERCE,2,10) > 1 then
		ErrorCode=ErrorCode.."AI has been modified to use the ranged pierce exploit, this may be illegal on the RO you play, contact your game administrators if you are unsure."
	end

	-- Construct the output string based on errors
	local OutString
	if ErrorCode=="" then
		OutString="AzzyAI (hom) version "..Version.."\nMain version:"..MainVersion.."\nAzzyUtil version:"..AUVersion.."\nConstant version:"..CVersion.."\nConfig: "..ConfigVers.."\nTactics: "..TacticVers.." \nTime: "..os.date("%c").."\nLua Version:".._VERSION.."\nstarted successfully. \n This AI is installed properly"
	else
		OutString="AzzyAI (hom) version "..Version.."\nMain version:"..MainVersion.."\nAzzyUtil version:"..AUVersion.."\nConstant version:"..CVersion.."\nConfig: "..ConfigVers.."\nTactics: "..TacticVers.." \nTime: "..os.date("%c").."\nLua Version".._VERSION.."\nError: "..ErrorCode.." "..ErrorInfo
	end

	-- Write the output string to the file or display an error
	if OutFile == nil then
		Error("No write permissions for RO folder, please fix permissions on the RO folder in order to use AzzyAI. Version Info: "..OutString)
	else
		OutFile:write(OutString)
		OutFile:close()
	end
end

-- Function to get the size of a file
function fsize(file)
	local f=io.open(file,"r")
	local size = f:seek("end")
	f:close()
	return size
end

-- Call the WriteStartupLog function to log the startup process
WriteStartupLog(Version,ErrorCode,ErrorInfo)

-------------------------------
-- Add no code to this file
-------------------------------
