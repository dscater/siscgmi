<?php

namespace App\Http\Controllers;

use App\Models\OrdenGenerada;
use App\Models\OrdenTrabajo;
use Illuminate\Http\Request;

class OrdenGeneradaController extends Controller
{
    public function getByOrdenTrabajo(OrdenTrabajo $ordenTrabajo)
    {

        if (!$ordenTrabajo->orden_generada) {
            $ordenTrabajo->orden_generada()->create([]);
        }
        return response()->JSON($ordenTrabajo->orden_generada->load([
            "detalle_repuestos.repuesto", "detalle_herramientas.herramienta", "detalle_personals.personal",
        ]));
    }

    public function actualizaDocumentacion(OrdenGenerada $orden_generada, Request $request)
    {
        if ($orden_generada->archivo == "") {
            $request->validate([
                "file" => "required|file"
            ]);
        }
        $orden_generada->update(array_map("mb_strtoupper", $request->except("file")));
        if ($request->hasFile("file")) {
            if ($orden_generada->url_archivo) {
                \File::delete(public_path() . "/files/" . $orden_generada->archivo);
            }
            $file = $request->file("file");
            $extension = $file->getClientOriginalExtension();
            $nom_file = "og_" . $orden_generada->id . time() . "." . $extension;
            $file->move(public_path() . "/files/", $nom_file);
            $orden_generada->archivo = $nom_file;
            $orden_generada->save();
        }
        return response()->JSON([
            "sw" => true,
            "message" => "Registro(s) guardados correctamente",
            "orden_generada" => $orden_generada->load([
                "detalle_repuestos.repuesto", "detalle_herramientas.herramienta", "detalle_personals.personal",
            ])
        ]);
    }
    public function actualizaComentarios(OrdenGenerada $orden_generada, Request $request)
    {
        $request->validate([
            "comentario" => "required|min:2"
        ]);

        $orden_generada->update(array_map("mb_strtoupper", $request->all()));
        return response()->JSON([
            "sw" => true,
            "message" => "Registro(s) guardados correctamente",
            "orden_generada" => $orden_generada->load([
                "detalle_repuestos.repuesto", "detalle_herramientas.herramienta", "detalle_personals.personal",
            ])
        ]);
    }
}
