<?php

namespace App\Http\Controllers;

use App\Models\HistorialAccion;
use App\Models\Repuesto;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class RepuestoController extends Controller
{
    public $validacion = [
        "codigo" => "required",
        "nombre" => "required",
        "descripcion" => "required",
        "equipo_id" => "required",
        "precio" => "required|numeric|min:1",
        "stock_min" => "required|numeric|min:1",
        "stock_max" => "required|numeric",
        "almacen" => "required",
    ];

    public $mensajes = [];

    public function index(Request $request)
    {
        $repuestos = Repuesto::all();
        return response()->JSON(['repuestos' => $repuestos, 'total' => count($repuestos)], 200);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            // crear Repuesto
            $request["stock_actual"] = 0;
            $nueva_repuesto = Repuesto::create(array_map('mb_strtoupper', $request->except("foto")));

            // if ($request->hasFile("foto")) {
            //     $file_foto = $request->file("foto");
            //     $nom_foto = $nueva_repuesto->id . time() . "." . $file_foto->getClientOriginalExtension();
            //     $file_foto->move(public_path() . "/imgs/repuestos/", $nom_foto);
            //     $nueva_repuesto->foto = $nom_foto;
            // }

            $nueva_repuesto->save();

            $datos_original = HistorialAccion::getDetalleRegistro($nueva_repuesto, "repuestos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UN REPUESTOS/INSUMO',
                'datos_original' => $datos_original,
                'modulo' => 'REPUESTOS/INSUMOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'repuesto' => $nueva_repuesto,
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

    public function update(Request $request, Repuesto $repuesto)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($repuesto, "repuestos");
            $repuesto->update(array_map('mb_strtoupper', $request->except("foto")));
            // if ($request->hasFile("foto")) {
            //     if ($repuesto->foto && $repuesto->foto != "") {
            //         \File::delete(public_path() . "/imgs/repuestos/" . $repuesto->foto);
            //     }
            //     $file_foto = $request->file("foto");
            //     $nom_foto = $repuesto->id . time() . "." . $file_foto->getClientOriginalExtension();
            //     $file_foto->move(public_path() . "/imgs/repuestos/", $nom_foto);
            //     $repuesto->foto = $nom_foto;
            // }

            $repuesto->save();

            $datos_nuevo = HistorialAccion::getDetalleRegistro($repuesto, "repuestos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UN REPUESTOS/INSUMO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'REPUESTOS/INSUMOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'repuesto' => $repuesto,
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

    public function show(Repuesto $repuesto)
    {
        return response()->JSON([
            'sw' => true,
            'repuesto' => $repuesto
        ], 200);
    }

    public function destroy(Repuesto $repuesto)
    {
        DB::beginTransaction();
        try {
            // if ($repuesto->foto && $repuesto->foto != "") {
            //     \File::delete(public_path() . "/imgs/repuestos/" . $repuesto->foto);
            // }

            $datos_original = HistorialAccion::getDetalleRegistro($repuesto, "repuestos");
            $repuesto->entradas()->delete();
            $repuesto->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UN REPUESTOS/INSUMO',
                'datos_original' => $datos_original,
                'modulo' => 'REPUESTOS/INSUMOS',
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
