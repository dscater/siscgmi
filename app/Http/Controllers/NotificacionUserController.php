<?php

namespace App\Http\Controllers;

use App\Models\NotificacionUser;
use App\Models\User;
use Illuminate\Http\Request;

class NotificacionUserController extends Controller
{
    public function notificacions(User $user)
    {
        $notificacions = NotificacionUser::with("notificacion")->where("user_id", $user->id)->orderBy("created_at", "desc")->get();
        $total = count($notificacions);
        $sin_ver = count($user->notificacions_user()->where("visto", 0)->get());
        return response()->JSON([
            "sw" => true,
            "total" => $total,
            "sin_ver" => $sin_ver,
            "notificacions" => $notificacions
        ]);
    }

    public function show(NotificacionUser $notificacion_user)
    {
        $notificacion = $notificacion_user->notificacion;
        if ($notificacion->tipo == 'GENERACIÓN DE OT') {
            $notificacion = $notificacion->load(["orden_generada.orden.gama.equipo", "orden_generada.orden.subunidad"]);
        }
        if ($notificacion->tipo == 'PEDIDO DE REPUESTO') {
            $notificacion = $notificacion->load(["pedido_repuesto.detalle_pedidos.repuesto", "pedido_repuesto.orden_trabajo"]);
        }

        if ($notificacion->tipo == 'CAMBIO DE ESTADO OT') {
            $notificacion = $notificacion->load(["orden_trabajo"]);
        }

        $notificacion_user->visto = 1;
        $notificacion_user->save();
        return response()->JSON([
            "notificacion" => $notificacion,
            "notificacion_user" => $notificacion_user,
        ]);
    }
}
