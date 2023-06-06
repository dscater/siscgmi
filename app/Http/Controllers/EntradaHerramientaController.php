<?php

namespace App\Http\Controllers;

use App\Models\EntradaHerramienta;
use App\Models\HistorialAccion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class EntradaHerramientaController extends Controller
{
    public $validacion = [
        'herramienta_id' => 'required',
        'cantidad' => 'required|numeric|min:1',
        'precio' => 'required|numeric|min:1',
        'total' => 'required|numeric|min:1',
        'fecha' => 'required|date',
    ];

    public $mensajes = [];

    public function index(Request $request)
    {
        $entrada_herramientas = EntradaHerramienta::with("herramienta")->get();
        return response()->JSON(['entrada_herramientas' => $entrada_herramientas, 'total' => count($entrada_herramientas)], 200);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            // crear EntradaHerramienta
            $nuevo_entrada_herramienta = EntradaHerramienta::create(array_map('mb_strtoupper', $request->all()));

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_entrada_herramienta, "entrada_herramientas");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UNA ENTRADA DE HERRAMIENTA/EQUIPO DE PROTECCIÓN',
                'datos_original' => $datos_original,
                'modulo' => 'ENTRADA DE HERRAMIENTAS/EQUIPOS DE PROTECCIÓN',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'entrada_herramienta' => $nuevo_entrada_herramienta,
                'msj' => 'El registro se realizó de forma correcta',
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function update(Request $request, EntradaHerramienta $entrada_herramienta)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($entrada_herramienta, "entrada_herramientas");
            $entrada_herramienta->update(array_map('mb_strtoupper', $request->all()));

            $datos_nuevo = HistorialAccion::getDetalleRegistro($entrada_herramienta, "entrada_herramientas");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UNA ENTRADA DE HERRAMIENTA/EQUIPO DE PROTECCIÓN',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'ENTRADA DE HERRAMIENTAS/EQUIPOS DE PROTECCIÓN',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'entrada_herramienta' => $entrada_herramienta,
                'msj' => 'El registro se actualizó de forma correcta'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    public function show(EntradaHerramienta $entrada_herramienta)
    {
        return response()->JSON([
            'sw' => true,
            'entrada_herramienta' => $entrada_herramienta
        ], 200);
    }

    public function destroy(EntradaHerramienta $entrada_herramienta)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($entrada_herramienta, "entrada_herramientas");
            $entrada_herramienta->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UNA ENTRADA DE HERRAMIENTA/EQUIPO DE PROTECCIÓN',
                'datos_original' => $datos_original,
                'modulo' => 'ENTRADA DE HERRAMIENTAS/EQUIPOS DE PROTECCIÓN',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'msj' => 'El registro se eliminó correctamente'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->JSON([
                'sw' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
