module AutoGainCtrl

# offline part
export agc!
export agc

# online part
export setagc
export onlineagc!
export onlineagc

include("offline-agc.jl")
include("online-agc.jl")

end #module
