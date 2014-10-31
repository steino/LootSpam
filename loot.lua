local frame = CreateFrame('Frame', 'LootAnnounce')

frame:SetScript("OnEvent", function(self, event, ...)
      self[event](self, event, ...)
end)

frame.looted = {}

function frame:LOOT_OPENED(event, autoloot)
   if not (IsInRaid() and IsMasterLooter()) then return end

   local guid = UnitGUID"target"
   for i = GetNumLootItems(), 1, -1 do
      local qt = select(4, GetLootSlotInfo(i))
      local link = GetLootSlotLink(i)

      if qt >= 4 and not self.looted[guid] then
         SendChatMessage(link, "RAID")
      end
   end
   frame.looted[guid] = true
end

frame:RegisterEvent"LOOT_OPENED"
