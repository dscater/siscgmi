<?php

use App\Http\Controllers\AreaController;
use App\Http\Controllers\ConfiguracionController;
use App\Http\Controllers\DetalleHerramientaController;
use App\Http\Controllers\DetallePersonalController;
use App\Http\Controllers\DetalleRepuestoController;
use App\Http\Controllers\EntradaHerramientaController;
use App\Http\Controllers\EntradaRepuestoController;
use App\Http\Controllers\EquipoController;
use App\Http\Controllers\FamiliaController;
use App\Http\Controllers\FrecuenciaController;
use App\Http\Controllers\GamaDetallesController;
use App\Http\Controllers\GamaMantenimientoController;
use App\Http\Controllers\HerramientaController;
use App\Http\Controllers\HistorialTiempoController;
use App\Http\Controllers\IndicadorController;
use App\Http\Controllers\LoginController;
use App\Http\Controllers\MaquinariaController;
use App\Http\Controllers\ModeloDeterministicoController;
use App\Http\Controllers\ModeloRepuestoController;
use App\Http\Controllers\NotificacionUserController;
use App\Http\Controllers\OrdenGeneradaController;
use App\Http\Controllers\OrdenTrabajoController;
use App\Http\Controllers\PedidoRepuestoController;
use App\Http\Controllers\PersonalController;
use App\Http\Controllers\PlanMantenimientoController;
use App\Http\Controllers\ReporteController;
use App\Http\Controllers\RepuestoController;
use App\Http\Controllers\SistemaController;
use App\Http\Controllers\SubFamiliaController;
use App\Http\Controllers\SubunidadController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\VariableControlController;
use Illuminate\Support\Facades\Route;

// LOGIN
Route::post('/login', [LoginController::class, 'login']);
Route::post('/logout', [LoginController::class, 'logout']);

// CONFIGURACIÓN
Route::get('/configuracion/getConfiguracion', [ConfiguracionController::class, 'getConfiguracion']);

Route::middleware(['auth'])->group(function () {
    Route::post('/configuracion/update', [ConfiguracionController::class, 'update']);

    Route::prefix('admin')->group(function () {
        // Usuarios
        Route::get('usuarios/getUsuarioTipo', [UserController::class, 'getUsuarioTipo']);
        Route::get('usuarios/getUsuario/{usuario}', [UserController::class, 'getUsuario']);
        Route::get('usuarios/userActual', [UserController::class, 'userActual']);
        Route::get('usuarios/getInfoBox', [UserController::class, 'getInfoBox']);
        Route::get('usuarios/getPermisos/{usuario}', [UserController::class, 'getPermisos']);
        Route::get('usuarios/getEncargadosRepresentantes', [UserController::class, 'getEncargadosRepresentantes']);
        Route::post('usuarios/actualizaContrasenia/{usuario}', [UserController::class, 'actualizaContrasenia']);
        Route::post('usuarios/actualizaFoto/{usuario}', [UserController::class, 'actualizaFoto']);
        Route::resource('usuarios', UserController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // areas
        Route::resource('areas', AreaController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // sistemas
        Route::resource('sistemas', SistemaController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // equipos
        Route::resource('equipos', EquipoController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // subunidads
        Route::resource('subunidads', SubunidadController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // maquinarias
        Route::resource('maquinarias', MaquinariaController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // variable_controls
        Route::resource('variable_controls', VariableControlController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // frecuencias
        Route::get("frecuencias/getByVariableControl", [FrecuenciaController::class, "getByVariableControl"]);
        Route::resource('frecuencias', FrecuenciaController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // herramientas
        Route::resource('herramientas', HerramientaController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // entrada_herramientas
        Route::resource('entrada_herramientas', EntradaHerramientaController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // repuestos
        Route::resource('repuestos', RepuestoController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // entrada_repuestos
        Route::resource('entrada_repuestos', EntradaRepuestoController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // personal
        Route::resource('personals', PersonalController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // familia
        Route::resource('familias', FamiliaController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // sub_familia
        Route::resource('sub_familias', SubFamiliaController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // gama_mantenimiento
        Route::get("gama_mantenimientos/getTiempo/{gama_mantenimiento}", [GamaMantenimientoController::class, 'getTiempo']);
        Route::resource('gama_mantenimientos', GamaMantenimientoController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // gama_detalles
        Route::post("gama_detalles/cambiaEstado/{gama_detalle}", [GamaDetallesController::class, "cambiaEstado"]);

        // plan_mantenimiento
        Route::get("plan_mantenimientos/getPlanProgramacion", [PlanMantenimientoController::class, 'getPlanProgramacion']);
        Route::resource('plan_mantenimientos', PlanMantenimientoController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // orden_trabajos
        Route::put("orden_trabajos/actualiza_fecha/{orden_trabajo}", [OrdenTrabajoController::class, 'actualiza_fecha']);
        Route::get("orden_trabajos/getByAnioSemana", [OrdenTrabajoController::class, 'getByAnioSemana']);
        Route::get("orden_trabajos/getByAnioMes", [OrdenTrabajoController::class, 'getByAnioMes']);
        Route::get("orden_trabajos/getAniosOt", [OrdenTrabajoController::class, 'getAniosOt']);
        Route::get("orden_trabajos/lista_clasificados", [OrdenTrabajoController::class, 'lista_clasificados']);
        Route::get("orden_trabajos/getTiempoEjecucion", [OrdenTrabajoController::class, 'getTiempoEjecucion']);
        Route::post("orden_trabajos/registraNuevoEstado/{orden_trabajo}", [OrdenTrabajoController::class, 'registraNuevoEstado']);
        Route::post("orden_trabajos/registraTerminarOT/{orden_trabajo}", [OrdenTrabajoController::class, 'registraTerminarOT']);
        Route::get("orden_trabajos/getWithOrdenGenerada/{orden_trabajo}", [OrdenTrabajoController::class, 'getWithOrdenGenerada']);
        Route::get("orden_trabajos/get/orden_trabajos/programados_fecha", [OrdenTrabajoController::class, 'programados_fecha']);
        Route::resource('orden_trabajos', OrdenTrabajoController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // orden_generadas
        Route::get("orden_generadas/getByOrdenTrabajo/{orden_trabajo}", [OrdenGeneradaController::class, "getByOrdenTrabajo"]);
        Route::post("orden_generadas/actualizaDocumentacion/{orden_generada}", [OrdenGeneradaController::class, "actualizaDocumentacion"]);
        Route::post("orden_generadas/actualizaComentarios/{orden_generada}", [OrdenGeneradaController::class, "actualizaComentarios"]);

        // pedido_repuestos
        Route::resource('pedido_repuestos', PedidoRepuestoController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // detalle_repuestos
        Route::post("detalle_repuestos/cambiaEstado/{detalle_repuesto}", [DetalleRepuestoController::class, "cambiaEstado"]);
        Route::post("detalle_repuestos/store/{orden_generada}", [DetalleRepuestoController::class, "store"]);

        //detalle_herramientas
        Route::post("detalle_herramientas/cambiaEstado/{detalle_herramienta}", [DetalleHerramientaController::class, "cambiaEstado"]);
        Route::post("detalle_herramientas/store/{orden_generada}", [DetalleHerramientaController::class, "store"]);

        //detalle_personals
        Route::post("detalle_personals/cambiaEstado/{detalle_personal}", [DetallePersonalController::class, "cambiaEstado"]);
        Route::post("detalle_personals/store/{orden_generada}", [DetallePersonalController::class, "store"]);

        //notificacions
        Route::get("notificacions/user/{user}", [NotificacionUserController::class, 'notificacions']);
        Route::get("notificacions/{notificacion_user}", [NotificacionUserController::class, 'show']);

        // historial_tiempos
        Route::get("historial_tiempos/verifica_registro", [HistorialTiempoController::class, 'verifica_registro']);
        Route::resource('historial_tiempos', HistorialTiempoController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // indicadors
        Route::get('indicadors/getNro', [IndicadorController::class, 'getNro']);
        Route::get('indicadors/getMTFB', [IndicadorController::class, 'getMTFB']);
        Route::get('indicadors/getMTTR', [IndicadorController::class, 'getMTTR']);
        Route::get('indicadors/getDisponibilidad', [IndicadorController::class, 'getDisponibilidad']);

        // modelo_deterministicos
        Route::get('modelo_deterministicos/getModelos/{repuesto}', [ModeloDeterministicoController::class, 'getModelos']);
        Route::get('modelo_deterministicos/getPromedioRepuestos', [ModeloDeterministicoController::class, 'getPromedioRepuestos']);
        Route::resource('modelo_deterministicos', ModeloDeterministicoController::class)->only([
            'index', 'store', 'update', 'destroy', 'show'
        ]);

        // modelo_repuestos
        Route::get('modelo_repuestos/getModeloRepuesto', [ModeloRepuestoController::class, 'getModeloRepuesto']);

        // REPORTES
        Route::post('reportes/usuarios', [ReporteController::class, 'usuarios']);
        Route::post('reportes/kardex_herramientas', [ReporteController::class, 'kardex_herramientas']);
        Route::post('reportes/informacion_herramientas', [ReporteController::class, 'informacion_herramientas']);
        Route::post('reportes/inform_solicitudes', [ReporteController::class, 'inform_solicitudes']);
        Route::post('reportes/kardex_repuestos', [ReporteController::class, 'kardex_repuestos']);
        Route::post('reportes/entrada_salida_repuestos', [ReporteController::class, 'entrada_salida_repuestos']);
        Route::post('reportes/plan_mantenimiento', [ReporteController::class, 'plan_mantenimiento']);
        Route::post('reportes/maestro_plan_mantenimiento', [ReporteController::class, 'maestro_plan_mantenimiento']);
        Route::post('reportes/historial_fallas', [ReporteController::class, 'historial_fallas']);
        Route::post('reportes/seguimiento_costos', [ReporteController::class, 'seguimiento_costos']);
        Route::post('reportes/informe_general', [ReporteController::class, 'informe_general']);
        Route::post('reportes/informe_ot_correctivas', [ReporteController::class, 'informe_ot_correctivas']);
        Route::post('reportes/resumen_ots', [ReporteController::class, 'resumen_ots']);
        Route::post('reportes/grafico_ots', [ReporteController::class, 'grafico_ots']);
    });
});


// ---------------------------------------
Route::get('/{optional?}', function () {
    return view('app');
})->name('base_path')->where('optional', '.*');
