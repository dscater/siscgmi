<?php

namespace App\Http\Controllers;

use App\Models\Herramienta;
use App\Models\HistorialAccion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class HerramientaController extends Controller
{
    public $validacion = [
        "codigo" => "required",
        "nombre" => "required",
        "descripcion" => "required",
        "proveedor" => "required",
        "almacen" => "required",
    ];

    public $mensajes = [];

    public function index(Request $request)
    {
        $herramientas = Herramienta::all();
        return response()->JSON(['herramientas' => $herramientas, 'total' => count($herramientas)], 200);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            // crear Herramienta
            $nueva_herramienta = Herramienta::create(array_map('mb_strtoupper', $request->except("foto")));

            if ($request->hasFile("foto")) {
                $file_foto = $request->file("foto");
                $nom_foto = $nueva_herramienta->id . time() . "." . $file_foto->getClientOriginalExtension();
                $file_foto->move(public_path() . "/imgs/herramientas/", $nom_foto);
                $nueva_herramienta->foto = $nom_foto;
            }

            $nueva_herramienta->save();

            $datos_original = HistorialAccion::getDetalleRegistro($nueva_herramienta, "herramientas");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UN SISTEMA',
                'datos_original' => $datos_original,
                'modulo' => 'SISTEMAS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'herramienta' => $nueva_herramienta,
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

    public function update(Request $request, Herramienta $herramienta)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($herramienta, "herramientas");
            $herramienta->update(array_map('mb_strtoupper', $request->except("foto")));
            if ($request->hasFile("foto")) {
                if ($herramienta->foto && $herramienta->foto != "") {
                    \File::delete(public_path() . "/imgs/herramientas/" . $herramienta->foto);
                }
                $file_foto = $request->file("foto");
                $nom_foto = $herramienta->id . time() . "." . $file_foto->getClientOriginalExtension();
                $file_foto->move(public_path() . "/imgs/herramientas/", $nom_foto);
                $herramienta->foto = $nom_foto;
            }

            $herramienta->save();

            $datos_nuevo = HistorialAccion::getDetalleRegistro($herramienta, "herramientas");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UN SISTEMA',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'SISTEMAS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return response()->JSON([
                'sw' => true,
                'herramienta' => $herramienta,
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

    public function show(Herramienta $herramienta)
    {
        return response()->JSON([
            'sw' => true,
            'herramienta' => $herramienta
        ], 200);
    }

    public function destroy(Herramienta $herramienta)
    {
        DB::beginTransaction();
        try {
            if ($herramienta->foto && $herramienta->foto != "") {
                \File::delete(public_path() . "/imgs/herramientas/" . $herramienta->foto);
            }

            $datos_original = HistorialAccion::getDetalleRegistro($herramienta, "herramientas");
            $herramienta->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UN SISTEMA',
                'datos_original' => $datos_original,
                'modulo' => 'SISTEMAS',
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
