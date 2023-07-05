<?php

namespace App\Http\Controllers;

use App\Models\HistorialAccion;
use App\Models\Maquinaria;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use PDF;

class MaquinariaController extends Controller
{
    public $validacion = [
        "equipo_id" => "required",
        "codificacion" => "required",
        "descripcion" => "required",
        "prioridad" => "required",
        "ubicacion" => "required",
        "tipo" => "required",
        "estado" => "required"
    ];

    public $mensajes = [];

    public function index(Request $request)
    {
        $maquinarias = Maquinaria::with("equipo")->get();
        return response()->JSON(['maquinarias' => $maquinarias, 'total' => count($maquinarias)], 200);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            // crear Maquinaria
            $nueva_maquinaria = Maquinaria::create(array_map('mb_strtoupper', $request->except("foto", "archivo")));

            if ($request->hasFile("foto")) {
                $file_foto = $request->file("foto");
                $nom_foto = $nueva_maquinaria->id . time() . "." . $file_foto->getClientOriginalExtension();
                $file_foto->move(public_path() . "/imgs/maquinarias/", $nom_foto);
                $nueva_maquinaria->foto = $nom_foto;
            }

            if ($request->hasFile("archivo")) {
                $file_archivo = $request->file("archivo");
                $nom_archivo = $nueva_maquinaria->id . time() . "." . $file_archivo->getClientOriginalExtension();
                $file_archivo->move(public_path() . "/files/maquinarias/", $nom_archivo);
                $nueva_maquinaria->archivo = $nom_archivo;
            }

            $nueva_maquinaria->save();

            $datos_original = HistorialAccion::getDetalleRegistro($nueva_maquinaria, "maquinarias");
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
                'maquinaria' => $nueva_maquinaria,
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

    public function update(Request $request, Maquinaria $maquinaria)
    {
        $request->validate($this->validacion, $this->mensajes);

        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($maquinaria, "maquinarias");
            $maquinaria->update(array_map('mb_strtoupper', $request->except("foto", "archivo")));
            if ($request->hasFile("foto")) {
                if ($maquinaria->foto && $maquinaria->foto != "") {
                    \File::delete(public_path() . "/imgs/maquinarias/" . $maquinaria->foto);
                }
                $file_foto = $request->file("foto");
                $nom_foto = $maquinaria->id . time() . "." . $file_foto->getClientOriginalExtension();
                $file_foto->move(public_path() . "/imgs/maquinarias/", $nom_foto);
                $maquinaria->foto = $nom_foto;
            }
            if ($request->hasFile("archivo")) {
                if ($maquinaria->archivo && $maquinaria->archivo != "") {
                    \File::delete(public_path() . "/files/maquinarias/" . $maquinaria->archivo);
                }
                $file_archivo = $request->file("archivo");
                $nom_archivo = $maquinaria->id . time() . "." . $file_archivo->getClientOriginalExtension();
                $file_archivo->move(public_path() . "/files/maquinarias/", $nom_archivo);
                $maquinaria->archivo = $nom_archivo;
            }
            $maquinaria->save();

            $datos_nuevo = HistorialAccion::getDetalleRegistro($maquinaria, "maquinarias");
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
                'maquinaria' => $maquinaria,
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

    public function show(Maquinaria $maquinaria)
    {
        return response()->JSON([
            'sw' => true,
            'maquinaria' => $maquinaria
        ], 200);
    }

    public function destroy(Maquinaria $maquinaria)
    {
        DB::beginTransaction();
        try {
            if ($maquinaria->foto && $maquinaria->foto != "") {
                \File::delete(public_path() . "/imgs/maquinarias/" . $maquinaria->foto);
            }
            if ($maquinaria->archivo && $maquinaria->archivo != "") {
                \File::delete(public_path() . "/files/maquinarias/" . $maquinaria->archivo);
            }
            $datos_original = HistorialAccion::getDetalleRegistro($maquinaria, "maquinarias");
            $maquinaria->delete();
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

    public function pdf(Maquinaria $maquinaria){
        $pdf = PDF::loadView('reportes.maquinaria', compact('maquinaria'))->setPaper('letter', 'portrait');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->download('Maquinaria.pdf');
    }
}
