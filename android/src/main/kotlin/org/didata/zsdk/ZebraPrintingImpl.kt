package org.didata.zsdk

import StatusInfo
import ZebraPrinting

class ZebraPrintingImpl : ZebraPrinting {
    override fun checkPrinterStatusOverTCPIP(): StatusInfo {
        return StatusInfo(Status.UNKNOWN, Cause.UNKNOWN)
    }
}