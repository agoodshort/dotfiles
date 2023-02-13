return function()
    local status, fidget = pcall(require, "fidget")
    if not status then
        return
    end

    fidget.setup({ window = { blend = 0, border = "rounded" } })
end
