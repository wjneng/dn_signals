package com.datanexus.dn_signals

import android.content.Context
import com.qq.gdt.action.ActionUtils
import com.qq.gdt.action.GDTAction
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import org.json.JSONObject

class DnSignalsPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var appContext: Context
    private var isInitialized = false

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        appContext = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "dn_signals")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        try {
            if (requiresInitialized(call.method) && !isInitialized) {
                result.error(
                    "NOT_INITIALIZED",
                    "Call DnSignals.initialize() before ${call.method}.",
                    null
                )
                return
            }

            when (call.method) {
                "initialize" -> initialize(call, result)
                "start" -> {
                    GDTAction.start()
                    result.success(null)
                }
                "logAction" -> logAction(call, result)
                "getClickId" -> result.success(GDTAction.getClickID(appContext))
                "getChannelId" -> result.success(GDTAction.getChannelID(appContext))
                "getAutoStartEnabled" -> result.success(GDTAction.getAutoStartEnable())
                "setAutoStartEnabled" -> {
                    GDTAction.setAutoStartEnable(call.arguments as Boolean)
                    result.success(null)
                }
                "setAnidEnabled" -> {
                    GDTAction.setAnidEnable(call.arguments as Boolean)
                    result.success(null)
                }
                "setUserUniqueId" -> {
                    GDTAction.setUserUniqueId(call.arguments as String)
                    result.success(null)
                }
                "getCaid" -> result.success(null)
                "reportRegister" -> {
                    val args = call.requiredMap()
                    ActionUtils.onRegister(args.requiredString("method"), args.requiredBool("isSuccess"))
                    result.success(null)
                }
                "reportLogin" -> {
                    val args = call.requiredMap()
                    ActionUtils.onLogin(args.requiredString("method"), args.requiredBool("isSuccess"))
                    result.success(null)
                }
                "reportBindAccount" -> {
                    val args = call.requiredMap()
                    ActionUtils.onBindAccount(args.requiredString("type"), args.requiredBool("isSuccess"))
                    result.success(null)
                }
                "reportQuestFinish" -> {
                    val args = call.requiredMap()
                    ActionUtils.onQuestFinish(
                        args.requiredString("questId"),
                        args.requiredString("questType"),
                        args.requiredString("questName"),
                        args.requiredInt("questNumber"),
                        args.requiredString("description"),
                        args.requiredBool("isSuccess")
                    )
                    result.success(null)
                }
                "reportCreateRole" -> {
                    val args = call.requiredMap()
                    ActionUtils.onCreateRole(args.requiredString("role"))
                    result.success(null)
                }
                "reportUpdateLevel" -> {
                    val args = call.requiredMap()
                    ActionUtils.onUpdateLevel(args.requiredInt("level"))
                    result.success(null)
                }
                "reportViewContent" -> {
                    val args = call.requiredMap()
                    ActionUtils.onViewContent(
                        args.requiredString("contentType"),
                        args.requiredString("contentName"),
                        args.requiredString("contentId")
                    )
                    result.success(null)
                }
                "reportAddToCart" -> {
                    val args = call.requiredMap()
                    ActionUtils.onAddToCart(
                        args.requiredString("contentType"),
                        args.requiredString("contentName"),
                        args.requiredString("contentId"),
                        args.requiredInt("contentNumber"),
                        args.requiredBool("isSuccess")
                    )
                    result.success(null)
                }
                "reportCheckout" -> {
                    val args = call.requiredMap()
                    ActionUtils.onCheckout(
                        args.requiredString("contentType"),
                        args.requiredString("contentName"),
                        args.requiredString("contentId"),
                        args.requiredInt("contentNumber"),
                        args.requiredBool("isVirtualCurrency"),
                        args.requiredString("virtualCurrencyType"),
                        args.requiredString("realCurrencyType"),
                        args.requiredBool("isSuccess")
                    )
                    result.success(null)
                }
                "reportPurchase" -> {
                    val args = call.requiredMap()
                    ActionUtils.onPurchase(
                        args.requiredString("contentType"),
                        args.requiredString("contentName"),
                        args.requiredString("contentId"),
                        args.requiredInt("contentNumber"),
                        args.requiredString("paymentChannel"),
                        args.requiredString("realCurrency"),
                        args.requiredInt("currencyAmount"),
                        args.requiredBool("isSuccess")
                    )
                    result.success(null)
                }
                "reportAddPaymentChannel" -> {
                    val args = call.requiredMap()
                    ActionUtils.onAddPaymentChannel(
                        args.requiredString("channel"),
                        args.requiredBool("isSuccess")
                    )
                    result.success(null)
                }
                "reportRate" -> {
                    val args = call.requiredMap()
                    ActionUtils.onRateApp(args.requiredDouble("rate").toFloat())
                    result.success(null)
                }
                "reportShare" -> {
                    val args = call.requiredMap()
                    ActionUtils.onShare(args.requiredString("channel"), args.requiredBool("isSuccess"))
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        } catch (error: IllegalArgumentException) {
            result.error("INVALID_ARGUMENT", error.message, null)
        } catch (error: Throwable) {
            result.error("DN_SIGNALS_ERROR", error.message, null)
        }
    }

    private fun initialize(call: MethodCall, result: Result) {
        val args = call.requiredMap()
        val actionSetId = args.requiredString("actionSetId")
        val secretKey = args.requiredString("secretKey")
        val channelValue = args.optionalString("channel")
        val autoStartEnabled = args["autoStartEnabled"] as? Boolean
        val anidEnabled = args["anidEnabled"] as? Boolean
        val userUniqueId = args.optionalString("userUniqueId")

        if (autoStartEnabled != null) {
            GDTAction.setAutoStartEnable(autoStartEnabled)
        }
        if (anidEnabled != null) {
            GDTAction.setAnidEnable(anidEnabled)
        }
        if (!userUniqueId.isNullOrBlank()) {
            GDTAction.setUserUniqueId(userUniqueId)
        }

        if (channelValue.isNullOrBlank()) {
            GDTAction.init(appContext, actionSetId, secretKey)
        } else {
            GDTAction.init(appContext, actionSetId, secretKey, channelValue)
        }
        isInitialized = true
        result.success(null)
    }

    private fun logAction(call: MethodCall, result: Result) {
        val args = call.requiredMap()
        val actionName = args.requiredString("actionName")
        val parameters = args["parameters"] as? Map<*, *>
        if (parameters == null || parameters.isEmpty()) {
            GDTAction.logAction(actionName)
        } else {
            GDTAction.logAction(actionName, JSONObject(parameters))
        }
        result.success(null)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun requiresInitialized(method: String): Boolean {
        return method == "start" ||
            method == "logAction" ||
            method.startsWith("report")
    }
}

private fun MethodCall.requiredMap(): Map<*, *> {
    return arguments as? Map<*, *>
        ?: throw IllegalArgumentException("Arguments must be a map.")
}

private fun Map<*, *>.requiredString(key: String): String {
    val value = this[key] as? String
    if (value.isNullOrBlank()) {
        throw IllegalArgumentException("$key must be a non-empty string.")
    }
    return value
}

private fun Map<*, *>.optionalString(key: String): String? {
    return this[key] as? String
}

private fun Map<*, *>.requiredBool(key: String): Boolean {
    return this[key] as? Boolean
        ?: throw IllegalArgumentException("$key must be a boolean.")
}

private fun Map<*, *>.requiredInt(key: String): Int {
    val value = this[key] as? Number
        ?: throw IllegalArgumentException("$key must be a number.")
    return value.toInt()
}

private fun Map<*, *>.requiredDouble(key: String): Double {
    val value = this[key] as? Number
        ?: throw IllegalArgumentException("$key must be a number.")
    return value.toDouble()
}
