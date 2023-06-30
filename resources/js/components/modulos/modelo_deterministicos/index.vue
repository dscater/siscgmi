<template>
    <div class="content-wrapper">
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>Modelo Deterministico</h1>
                    </div>
                </div>
            </div>
        </section>
        <section class="content">
            <div class="container-fluid">
                <div class="row pl-1 pr-1">
                    <div class="col-md-4 pl-0 pr-0">
                        <router-link
                            v-if="permisos.includes('modelo_deterministicos.parametros')"
                            :to="{
                                name: 'modelo_deterministicos.parametros',
                            }"
                            class="btn btn-primary btn-flat btn-block border-white"
                        >
                            <i class="fa fa-list-alt"></i>
                            Cálculo de Parámetros
                        </router-link>
                    </div>
                    <div class="col-md-4 pl-0 pr-0">
                        <router-link
                            v-if="permisos.includes('modelo_deterministicos.modelo_repuestos')"
                            :to="{
                                name: 'modelo_deterministicos.modelo_repuestos',
                            }"
                            class="btn btn-primary btn-flat btn-block border-white"
                        >
                            <i class="fa fa-list-alt"></i>
                            Modelo Deterministico de Repuestos
                        </router-link>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <div class="row">
                                    <div class="col-md-3">
                                        <router-link
                                            v-if="
                                                permisos.includes(
                                                    'modelo_deterministicos.create'
                                                )
                                            "
                                            :to="{
                                                name: 'modelo_deterministicos.create',
                                            }"
                                            class="btn btn-primary btn-flat btn-block"
                                        >
                                            <i class="fa fa-plus"></i>
                                            Nuevo
                                        </router-link>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <b-col lg="10" class="my-1">
                                        <b-form-group
                                            label="Buscar"
                                            label-for="filter-input"
                                            label-cols-sm="3"
                                            label-align-sm="right"
                                            label-size="sm"
                                            class="mb-0"
                                        >
                                            <b-input-group size="sm">
                                                <b-form-input
                                                    id="filter-input"
                                                    v-model="filter"
                                                    type="search"
                                                    placeholder="Buscar"
                                                ></b-form-input>

                                                <b-input-group-append>
                                                    <b-button
                                                        class="bg-primary"
                                                        variant="primary"
                                                        :disabled="!filter"
                                                        @click="filter = ''"
                                                        >Borrar</b-button
                                                    >
                                                </b-input-group-append>
                                            </b-input-group>
                                        </b-form-group>
                                    </b-col>
                                    <div class="col-md-12">
                                        <b-overlay
                                            :show="showOverlay"
                                            rounded="sm"
                                        >
                                            <b-table
                                                :fields="fields"
                                                :items="listRegistros"
                                                show-empty
                                                stacked="md"
                                                responsive
                                                :current-page="currentPage"
                                                :per-page="perPage"
                                                @filtered="onFiltered"
                                                empty-text="Sin resultados"
                                                empty-filtered-text="Sin resultados"
                                                :filter="filter"
                                            >
                                                <template #cell(detalles)="row">
                                                    <b-button
                                                        size="sm"
                                                        variant="primary"
                                                        @click="
                                                            row.toggleDetails
                                                        "
                                                    >
                                                        {{
                                                            row.detailsShowing
                                                                ? "Ocultar"
                                                                : "Ver"
                                                        }}
                                                        Detalles
                                                    </b-button>
                                                </template>
                                                <template #row-details="row">
                                                    <b-card>
                                                        <h4 class="text-sm">
                                                            COSTO POR ORDENDAR
                                                        </h4>
                                                        <ul>
                                                            <li>
                                                                Salario Mensual:
                                                                <span>{{
                                                                    row.item.sm
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Inversión de
                                                                Tiempo/Hora:
                                                                <span>{{
                                                                    row.item.it
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Costo de
                                                                Procesamiento de
                                                                la Orden:
                                                                <span>{{
                                                                    row.item.cpo
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Costo de
                                                                Transporte por
                                                                Ordenar:
                                                                <span>{{
                                                                    row.item
                                                                        .ct_ordenar
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Costo de
                                                                Inspección:
                                                                <span>{{
                                                                    row.item
                                                                        .c_ins
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Costo de
                                                                Empaquetado:
                                                                <span>{{
                                                                    row.item
                                                                        .c_em
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Costo por
                                                                Ordenar:
                                                                <span>{{
                                                                    row.item
                                                                        .c_ordenar
                                                                }}</span>
                                                            </li>
                                                        </ul>
                                                        <h4 class="text-sm">
                                                            COSTO POR
                                                            ADQUISICIÓN
                                                        </h4>
                                                        <ul>
                                                            <li>
                                                                Precio de
                                                                Compra:
                                                                <span>{{
                                                                    row.item
                                                                        .precio_compra
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Costos de
                                                                Transporte por
                                                                Adquisición:
                                                                <span>{{
                                                                    row.item
                                                                        .ct_adqui
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Costos de
                                                                Importación:
                                                                <span>{{
                                                                    row.item
                                                                        .c_impor
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Costos de
                                                                Almacenamiento
                                                                Externo:
                                                                <span>{{
                                                                    row.item
                                                                        .c_alma_ext
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Otros Costos por
                                                                Adquisición:
                                                                <span>{{
                                                                    row.item
                                                                        .oc_adqui
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Costo por
                                                                Adquisición:
                                                                <span>{{
                                                                    row.item
                                                                        .c_adqui
                                                                }}</span>
                                                            </li>
                                                        </ul>
                                                        <h4 class="text-sm">
                                                            COSTOS DE
                                                            MANTENIMIENTO
                                                        </h4>
                                                        <ul>
                                                            <li>
                                                                Costo de
                                                                Alquiler de
                                                                Espacio:
                                                                <span>{{
                                                                    row.item
                                                                        .c_alqui
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Área Ocupada:
                                                                <span>{{
                                                                    row.item
                                                                        .area_ocupada
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Costo del
                                                                Espacio:
                                                                <span>{{
                                                                    row.item
                                                                        .c_espa
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Valor Promedio
                                                                de Repuestos:
                                                                <span>{{
                                                                    row.item
                                                                        .vp_rep
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Cantidad
                                                                Promedio de
                                                                Repuestos:
                                                                <span>{{
                                                                    row.item
                                                                        .cantp_rep
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Costo Promedio
                                                                de Repuestos:
                                                                <span>{{
                                                                    row.item
                                                                        .costop_rep
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Tasa de Interés
                                                                Anual:
                                                                <span
                                                                    >{{
                                                                        row.item
                                                                            .tasa_ia
                                                                    }}
                                                                    -
                                                                    {{
                                                                        row.item
                                                                            .tasa_ia_calculado
                                                                    }}</span
                                                                >
                                                            </li>
                                                            <li>
                                                                Costo de
                                                                Capital:
                                                                <span>{{
                                                                    row.item
                                                                        .costo_capital
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Costo Total de
                                                                Almacenamiento:
                                                                <span>{{
                                                                    row.item
                                                                        .ct_almacenamiento
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Costo de
                                                                Depreciación:
                                                                <span>{{
                                                                    row.item
                                                                        .c_depreciacion
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Costo de Gestión
                                                                de Inventario:
                                                                <span>{{
                                                                    row.item
                                                                        .c_gi
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Otros Costos de
                                                                Mantenimiento:
                                                                <span>{{
                                                                    row.item
                                                                        .oc_mantenimiento
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Costo de
                                                                Mantenimiento:
                                                                <span>{{
                                                                    row.item
                                                                        .c_mantenimiento
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Procesamiento
                                                                del Periodo en
                                                                Horas:
                                                                <span
                                                                    >{{
                                                                        row.item
                                                                            .procesamiento_pedido
                                                                    }}
                                                                    -
                                                                    {{
                                                                        row.item
                                                                            .procesamiento_pedido_calculado
                                                                    }}</span
                                                                >
                                                            </li>
                                                            <li>
                                                                Fabricación
                                                                Producción Días:
                                                                <span>{{
                                                                    row.item
                                                                        .fabricacion_productos
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Tiempo de
                                                                Transito Días:
                                                                <span>{{
                                                                    row.item
                                                                        .tiempo_transito
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Inspección y
                                                                Control Días:
                                                                <span>{{
                                                                    row.item
                                                                        .inspeccion_control
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                LEAD TIME:
                                                                <span>{{
                                                                    row.item
                                                                        .leadtime
                                                                }}</span>
                                                            </li>
                                                            <li>
                                                                Unidad de
                                                                Tiempo:
                                                                <span>{{
                                                                    row.item
                                                                        .unidad
                                                                }}</span>
                                                            </li>
                                                        </ul>
                                                    </b-card>
                                                    <b-button
                                                        size="sm"
                                                        variant="primary"
                                                        @click="
                                                            row.toggleDetails
                                                        "
                                                    >
                                                        Ocultar Detalles
                                                    </b-button>
                                                    <b-button
                                                        size="sm"
                                                        pill
                                                        variant="outline-warning"
                                                        class="btn-flat"
                                                        title="Editar registro"
                                                        @click="
                                                            editarRegistro(
                                                                row.item
                                                            )
                                                        "
                                                    >
                                                        <i
                                                            class="fa fa-edit"
                                                        ></i>
                                                    </b-button>
                                                    <b-button
                                                        size="sm"
                                                        pill
                                                        variant="outline-danger"
                                                        class="btn-flat"
                                                        title="Eliminar registro"
                                                        @click="
                                                            eliminaModeloDeterministico(
                                                                row.item.id,
                                                                row.item
                                                                    .codigo +
                                                                    ' | ' +
                                                                    row.item
                                                                        .nombre
                                                            )
                                                        "
                                                    >
                                                        <i
                                                            class="fa fa-trash"
                                                        ></i>
                                                    </b-button>
                                                </template>

                                                <template
                                                    #cell(fecha_registro)="row"
                                                >
                                                    {{
                                                        formatoFecha(
                                                            row.item
                                                                .fecha_registro
                                                        )
                                                    }}
                                                </template>

                                                <template #cell(accion)="row">
                                                    <div
                                                        class="row justify-content-between"
                                                    >
                                                        <b-button
                                                            size="sm"
                                                            pill
                                                            variant="outline-warning"
                                                            class="btn-flat btn-block"
                                                            title="Editar registro"
                                                            @click="
                                                                editarRegistro(
                                                                    row.item
                                                                )
                                                            "
                                                        >
                                                            <i
                                                                class="fa fa-edit"
                                                            ></i>
                                                        </b-button>
                                                        <b-button
                                                            size="sm"
                                                            pill
                                                            variant="outline-danger"
                                                            class="btn-flat btn-block"
                                                            title="Eliminar registro"
                                                            @click="
                                                                eliminaModeloDeterministico(
                                                                    row.item.id,
                                                                    row.item
                                                                        .codigo +
                                                                        ' | ' +
                                                                        row.item
                                                                            .nombre
                                                                )
                                                            "
                                                        >
                                                            <i
                                                                class="fa fa-trash"
                                                            ></i>
                                                        </b-button>
                                                    </div>
                                                </template>
                                            </b-table>
                                        </b-overlay>
                                        <div class="row">
                                            <b-col
                                                sm="6"
                                                md="2"
                                                class="ml-auto my-1"
                                            >
                                                <b-form-select
                                                    align="right"
                                                    id="per-page-select"
                                                    v-model="perPage"
                                                    :options="pageOptions"
                                                    size="sm"
                                                ></b-form-select>
                                            </b-col>
                                            <b-col
                                                sm="6"
                                                md="2"
                                                class="my-1 mr-auto"
                                                v-if="perPage"
                                            >
                                                <b-pagination
                                                    v-model="currentPage"
                                                    :total-rows="totalRows"
                                                    :per-page="perPage"
                                                    align="left"
                                                ></b-pagination>
                                            </b-col>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</template>

<script>
export default {
    data() {
        return {
            permisos: localStorage.getItem("permisos"),
            search: "",
            listRegistros: [],
            showOverlay: false,
            fields: [
                { key: "codigo", label: "Código", sortable: true },
                { key: "nombre", label: "Nombre", sortable: true },
                { key: "descripcion", label: "Descripción", sortable: true },
                {
                    key: "repuesto.full_name",
                    label: "Repuesto",
                    sortable: true,
                },
                { key: "detalles", label: "Detalles", sortable: true },
                { key: "accion", label: "Acción" },
            ],
            loading: true,
            fullscreenLoading: true,
            loadingWindow: Loading.service({
                fullscreen: this.fullscreenLoading,
            }),
            muestra_modal: false,
            modal_accion: "nuevo",
            currentPage: 1,
            perPage: 5,
            pageOptions: [
                { value: 5, text: "Mostrar 5 Registros" },
                { value: 10, text: "Mostrar 10 Registros" },
                { value: 25, text: "Mostrar 25 Registros" },
                { value: 50, text: "Mostrar 50 Registros" },
                { value: 100, text: "Mostrar 100 Registros" },
                { value: this.totalRows, text: "Mostrar Todo" },
            ],
            totalRows: 10,
            filter: null,
        };
    },
    mounted() {
        this.loadingWindow.close();
        this.getModeloDeterministicos();
    },
    methods: {
        // Seleccionar Opciones de Tabla
        editarRegistro(item) {
            this.$router.push({
                name: "modelo_deterministicos.edit",
                params: {
                    id: item.id,
                },
            });
        },

        // Listar ModeloDeterministicos
        getModeloDeterministicos() {
            this.showOverlay = true;
            this.muestra_modal = false;
            let url = "/admin/modelo_deterministicos";
            if (this.pagina != 0) {
                url += "?page=" + this.pagina;
            }
            axios
                .get(url, {
                    params: { per_page: this.per_page },
                })
                .then((res) => {
                    this.showOverlay = false;
                    this.listRegistros = res.data.modelo_deterministicos;
                    this.totalRows = res.data.total;
                });
        },
        eliminaModeloDeterministico(id, descripcion) {
            console.log(descripcion);
            Swal.fire({
                title: "¿Quierés eliminar este registro?",
                html: `<strong>${descripcion}</strong><br>`,
                showCancelButton: true,
                confirmButtonColor: "#149FDA",
                confirmButtonText: "Si, eliminar",
                cancelButtonText: "No, cancelar",
                denyButtonText: `No, cancelar`,
            }).then((result) => {
                /* Read more about isConfirmed, isDenied below */
                if (result.isConfirmed) {
                    axios
                        .post("/admin/modelo_deterministicos/" + id, {
                            _method: "DELETE",
                        })
                        .then((res) => {
                            this.getModeloDeterministicos();
                            this.filter = "";
                            Swal.fire({
                                icon: "success",
                                title: res.data.msj,
                                showConfirmButton: false,
                                timer: 1500,
                            });
                        })
                        .catch((error) => {
                            if (error.response) {
                                if (error.response.status === 422) {
                                    this.errors = error.response.data.errors;
                                }
                                if (
                                    error.response.status === 420 ||
                                    error.response.status === 419 ||
                                    error.response.status === 401
                                ) {
                                    window.location = "/";
                                }
                                if (error.response.status === 500) {
                                    Swal.fire({
                                        icon: "error",
                                        title: "Error",
                                        html: error.response.data.message,
                                        showConfirmButton: false,
                                        timer: 2000,
                                    });
                                }
                            }
                        });
                }
            });
        },
        onFiltered(filteredItems) {
            // Trigger pagination to update the number of buttons/pages due to filtering
            this.totalRows = filteredItems.length;
            this.currentPage = 1;
        },
        formatoFecha(date) {
            if (date) {
                return this.$moment(String(date)).format("DD/MM/YYYY");
            }
            return "";
        },
    },
};
</script>

<style></style>
