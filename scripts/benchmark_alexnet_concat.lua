--[[
    Benchmark the AlexNet model with the concat classifier network.
]]


local function exec_command(command)
    print('\n')
    print('Executing command: ' .. command)
    print('\n')
    os.execute(command)
end


--[[ Setup train configurations ]]--
local configs = paths.dofile('configs_alexnet.lua')
configs.expID = 'caltech_10x_alexnet_concat'
configs.clsType = 'simple'
configs.eval_plot_name = 'OURS-alexnet-concat'

--[[ concatenate options fields to a string ]]--
local str_args = ''
for k, v in pairs(configs) do
    str_args = str_args .. ('-%s %s '):format(k, v)
end

--[[ set cuda GPUs ]]--
local str_cuda
if configs.nGPU <= 1 then
    str_cuda = 'CUDA_VISIBLE_DEVICES=1'
else
    str_cuda = 'CUDA_VISIBLE_DEVICES=1,0'
end

--[[ train network ]]--
exec_command(('%s th benchmark.lua %s'):format(str_cuda, str_args))