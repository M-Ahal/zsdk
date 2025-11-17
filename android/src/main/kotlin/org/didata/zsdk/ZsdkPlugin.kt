package org.didata.zsdk

import io.flutter.embedding.engine.plugins.FlutterPlugin

class ZsdkPlugin : FlutterPlugin {
    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        ZebraPrinting.Companion.setUp(flutterPluginBinding.binaryMessenger, ZebraPrintingImpl())
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {

    }
}
