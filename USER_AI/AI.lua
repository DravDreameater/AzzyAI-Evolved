-----------------------------
-- Dr. Azzy's Homunculus AI
-- Written by Dr. Azzy of iRO Loki
-- Permission granted to distribute in unmodified form
-- Please contact me via the iRO Forums if you wish to modify
-- so that we can work together to extend and improve this AI.
-----------------------------
Version="1.56" -- Current version of the AI
ErrorCode="" -- Variable to store error codes
ErrorInfo="" -- Variable to store error information
LastSavedDate="" -- Last saved date for configuration
TactLastSavedDate="" -- Last saved date for tactics
TypeString="H" -- Type of AI (Homunculus)

-- Load required files for the AI
dofile("./AI/USER_AI/Const_.lua")
dofile("./AI/USER_AI/H_SkillList.lua") 
dofile("./AI/USER_AI/Defaults.lua")
dofile("./AI/USER_AI/AzzyUtil.lua")
dofile("./AI/USER_AI/Stubs.lua")
dofile("./AI/USER_AI/A_Friends.lua")
dofile("./AI/USER_AI/H_Config.lua")
dofile("./AI/USER_AI/H_Tactics.lua")
dofile("./AI/USER_AI/AI_main.lua")
dofile("./AI/USER_AI/H_PVP_Tact.lua")
dofile("./AI/USER_AI/H_Avoid.lua")
dofile("./AI/USER_AI/H_Extra.lua")

-- Function to write a startup log and validate file versions
function WriteStartupLog(Version, ErrorCode, ErrorInfo)
	local verspattern = "%d.%d%d" -- Pattern to match version numbers

	-- Check the version of AzzyUtil.lua
	if AUVersion == nil then
		AUVersion = "1.30b or earlier"
		ErrorCode = "File version error"
		ErrorInfo = ErrorInfo .. "AzzyUtil.lua no version found"
	elseif string.gfind(AUVersion, verspattern)() ~= "1.552" then
		ErrorCode = "File version error"
		ErrorInfo = ErrorInfo .. "AzzyUtil.lua wrong version " .. string.gfind(AUVersion, verspattern)() .. "\n"
	end

	-- Test if the data folder is writable
	TestFile = io.open("./AI/USER_AI/data/test.txt", "w")
	if TestFile ~= nil then
		TestFile:close()
	else
		ErrorCode = "cannot create files in data folder"
		ErrorInfo = ErrorInfo .. " Data folder likely missing. Create folder named 'data' in USER_AI "
	end

	-- Check the version of Const_.lua
	if CVersion == nil then
		CVersion = "1.30b or earlier"
		ErrorCode = "File version error"
		ErrorInfo = ErrorInfo .. "Const_.lua no version found"
	elseif string.gfind(CVersion, verspattern)() ~= "1.56" then
		ErrorCode = "File version error"
		ErrorInfo = ErrorInfo .. "Const_.lua wrong version " .. string.gfind(CVersion, verspattern)() .. "\n"
	end

	-- Check the version of AI_main.lua
	if MainVersion == nil then
		MainVersion = "1.30b or earlier"
		ErrorCode = "File version error"
		ErrorInfo = ErrorInfo .. " AI_main.lua no version found"
	elseif string.gfind(MainVersion, verspattern)() ~= "1.56" then
		ErrorCode = "File version error"
		ErrorInfo = ErrorInfo .. "AI_main.lua wrong version " .. string.gfind(MainVersion, verspattern)() .. "\n"
	end

	-- Check if H_Config.lua is default or custom
	if fsize("./AI/USER_AI/H_Config.lua") == 3898 then
		ConfigVers = "Default: " .. LastSavedDate
	else
		ConfigVers = "Custom, edited " .. LastSavedDate
	end

	-- Check if H_Tactics.lua is default or custom
	if fsize("./AI/USER_AI/H_Tactics.lua") == 5393 then
		TacticVers = "Default: " .. TactLastSavedDate
	else
		TacticVers = "Custom, edited " .. TactLastSavedDate
	end

	-- Prepare the output string for the log
	local OutString
	if ErrorCode == "" then
		OutString = "AzzyAI (hom) version " .. Version .. "\nMain version:" .. MainVersion .. "\nAzzyUtil version:" .. AUVersion .. "\nConstant version:" .. CVersion .. "\nConfig: " .. ConfigVers .. "\nTactics: " .. TacticVers .. " \nTime: " .. os.date("%c") .. "\nLua Version:" .. _VERSION .. "\nstarted successfully. \n This AI is installed properly"
	else
		OutString = "AzzyAI (hom) version " .. Version .. "\nMain version:" .. MainVersion .. "\nAzzyUtil version:" .. AUVersion .. "\nConstant version:" .. CVersion .. "\nConfig: " .. ConfigVers .. "\nTactics: " .. TacticVers .. " \nTime: " .. os.date("%c") .. "\nLua Version" .. _VERSION .. "\nError: " .. ErrorCode .. " " .. ErrorInfo
	end

	-- Write the log to a file
	OutFile = io.open("AAIStartH.txt", "w")
	if OutFile == nil then
		Error("No write permissions for RO folder, please fix permissions on the RO folder in order to use AzzyAI. Version Info: " .. OutString)
	else
		OutFile:write(OutString)
		OutFile:close()
	end
end

-- Function to get the size of a file
function fsize(file)
	local f = io.open(file, "r")
	local size = f:seek("end") -- Seek to the end of the file to get its size
	f:close()
	return size
end

-- Call the WriteStartupLog function to validate and log startup information
WriteStartupLog(Version, ErrorCode, ErrorInfo)

-------------------------------
-- Add no code to this file
---------------------------------
